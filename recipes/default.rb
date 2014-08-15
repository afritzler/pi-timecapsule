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
%w{hfsplus hfsutils hfsprogs}.each do |pkg|
  package pkg do
    action :install
  end
end

directory node['timecapsule_mount_dir'] do
  owner "pi"
  group "pi"
  mode 00777
end

# update fstab

# install & configure nettalk

# install & configure avahi deamon
%w{avahi-daemon libavahi-client-dev libdb5.3-dev db-util db5.3-util libgcrypt11 libgcrypt11-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/avahi/services/timecapsule_afpd.service" do
  source "timecapsule_afpd.service.erb"
end

# add nettalk and avahi deamon as default services
