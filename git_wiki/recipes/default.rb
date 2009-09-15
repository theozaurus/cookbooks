#
# Cookbook Name:: git-wiki
# Recipe:: default
#
# Copyright 2009, Jiva Technology
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

include_recipe "git"
include_recipe "vlad"

package "imagemagick"
package "libmagick9-dev"
package "cron"
package "ntp"

%w{ minad-creole
    minad-git
    minad-rack-esi
    minad-mimemagic
    rack-cache
    minad-imaginator
    minad-evaluator
    javan-whenever }.each do |new_gem|
  gem_package new_gem do
    action :install
    source "http://gems.github.com"
  end
end

%w{ haml
    rack
    hpricot
    rdiscount
    RedCloth
    maruku
    rubypants
    rmagick }.each do |new_gem|
  gem_package new_gem do
    action :install
  end
end


git_wiki = node[:git_wiki]

# Create user
user git_wiki[:user]  do
  home "/home/#{git_wiki[:user]}"
  shell "/bin/bash"
  supports :manage_home => true
end

# Setup authorized SSH keys
ssh_authorized_keys "wiki users" do
  user git_wiki[:user]
  keys git_wiki[:ssh_keys]
end

# Add github.com to the known hosts file
ssh_known_hosts "Adding github" do
  user git_wiki[:user]
  hosts ["github.com"]
end


