pi-timecapsule Cookbook
========================

Chef cookbook for setting up your Raspberry Pi as a backup server. The steps for
turning your Raspberry Pi into a TimeCapsule are taken from this
[Blog Post](http://www.tim-dau.de/mac/raspberry-pi-time-capsule-fuer-backups/)

Requirements
------------

* Raspberry Pi
* USB Harddrive formated with HDFS

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### pi-timecapsule::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['pi-timecapsule']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### pi-timecapsule::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `pi-timecapsule` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pi-timecapsule]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Andreas Fritzler

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this software except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
