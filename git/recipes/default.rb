#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2008, OpsCode
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


if node[:platform] == "ubuntu" && node[:platform_version] == "8.04"
  
  repos = ["deb http://ppa.launchpad.net/smartlounge/ppa/ubuntu hardy main",
           "deb-src http://ppa.launchpad.net/smartlounge/ppa/ubuntu hardy main"]
  
  repos.each do |r|
    bash "Adding repo #{r}" do
      code "echo '#{r}' >> /etc/apt/sources.list"
      not_if "grep '#{r}' /etc/apt/sources.list"
    end
  end

  key = "504EBE1344441FF0E7CC4CA30E76E800643C34E6"
  bash "Add key" do
    code ["gpg --no-default-keyring --keyring /tmp/sml.keyring --keyserver pgp.mit.edu --recv #{key}",
          "gpg --no-default-keyring --keyring /tmp/sml.keyring --export --armor #{key} | sudo apt-key add - ",
          "rm /tmp/sml.keyring",
          "apt-get update"].join("&&")
    not_if "apt-key list | grep 'Launchpad PPA for Smartlounge'"
  end
  
end

case node[:platform]
when "debian", "ubuntu"
  package "git-core"
else 
  package "git"
end

package "gitk"
package "git-svn"
package "git-email"
