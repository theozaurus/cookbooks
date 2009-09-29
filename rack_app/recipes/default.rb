include_recipe "git"
include_recipe "rails"
include_recipe "apache2::mod_rails"
include_recipe "vlad"
include_recipe "mysql::server"

# Required for projects using Nokogiri
package "libxslt1-dev"
package "libxml2-dev"

package "cron"

rack_app = node[:rack_app]

# Create user
user rack_app[:user]  do
  home "/home/#{rack_app[:user]}"
  shell "/bin/bash"
  supports :manage_home => true
end

# Setup web server
web_app rack_app[:name] do
  template        "web_app.conf.erb"
  docroot         "#{rack_app[:path]}/current/public"
  server_name     rack_app[:domain]
  server_aliases  rack_app[:aliases]
  redirect        rack_app[:redirect]
  rails_env       rack_app[:rails][:environment]
end

# Disable default site
apache_site "000-default" do
  enable false
end

# Setup vlad support
vlad_setup rack_app[:name] do
  path  rack_app[:path]
  owner rack_app[:user]
  group rack_app[:group]
end

# Setup authorized SSH keys
ssh_authorized_keys "vlad users" do
  user rack_app[:user]
  keys rack_app[:ssh_keys]
end

# Add github.com to the known hosts file
ssh_known_hosts "Adding github" do
  user rack_app[:user]
  hosts ["github.com"]
end

# Create database
mysql_new_database rack_app[:database][:name]

# Setup database user
mysql_new_user rack_app[:database][:user] do
  password  rack_app[:database][:password]
  databases [rack_app[:database][:name]]
end