#
# Cookbook Name:: pi-timecapsule
# Recipe:: default
#
# Copyright 2014, Andreas Fritzler
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# install basic hdfs packages
%w{hfsplus hfsutils hfsprogs libtracker-sparql-0.14-dev libtracker-miner-0.14-dev tracker libglib2.0-dev libdbus-glib-1-dev libdbus-1-dev systemtap-sdt-dev libcrack2-dev libldap2-dev libacl1-dev libavahi-client-dev libmysqlclient-dev libdb-dev libwrap0-dev libpam0g-dev libkrb5-dev libgcrypt11-dev libssl-dev build-essential}.each do |pkg|
  package pkg do
    action :install
  end
end

directory node['timecapsule']['mount_point'] do
  owner "pi"
  group "pi"
  mode 00777
end

# update fstab
if File.readlines("/etc/fstab").grep(/TimeCapsule/).size == 0
  bash "update fstab" do
    user "root"
    cwd "/etc"
    code <<-EOH
    echo "LABEL=TimeCapsule   /media/TimeCapsule/  hfsplus rw,force,exec,auto,users 0 2" >> fstab
    EOH
  end
end

# install & configure netatalk
bash "install netatalk" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget http://prdownloads.sourceforge.net/netatalk/netatalk-3.1.6.tar.bz2
  tar -xvf netatalk-3.1.6.tar.bz2
  cd netatalk-3.1.6/
  ./configure \
        -with-init-style=debian-sysv \
        --with-cracklib \
        --enable-krbV-uam \
        --with-pam-confdir=/etc/pam.d \
        --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
        --with-tracker-pkgconfig-version=0.14
  make
  sudo make install
  EOH
end

template "/usr/local/etc/afp.conf" do
  mode "0644"
  source "afp.conf.erb"
  variables(
    :hostname => node['timecapsule']['hostname'],
    :mount_point => node['timecapsule']['mount_point']
  )
end

# install & configure avahi deamon
%w{avahi-daemon libavahi-client-dev libdb5.3-dev db-util db5.3-util libgcrypt11 libgcrypt11-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/avahi/services/timecapsule_afpd.service" do
  mode "0644"
  source "timecapsule_afpd.service.erb"
end

# add netatalk and avahi deamon as default services
bash "add bootup services" do
  user "root"
  code <<-EOH
  sudo update-rc.d netatalk defaults
  sudo update-rc.d avahi-daemon defaults
  EOH
end
