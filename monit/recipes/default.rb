package "flex"
package "bison"
package "curl"

package "libssl-dev"

package "monit" do
  action :purge
end

monit = node[:monit]

# Downloads monit
bash "Download monit" do
  cwd monit[:destination]
  code "curl #{monit[:link]} | tar xz"
  not_if "test -d #{monit[:folder]}"
end

# Setup SysV
remote_file "/etc/init.d/monit" do
  source "monit-init"
  mode "0755"
end

remote_file "/etc/default/monit" do
  source "monit-default"
  mode "0644"
end

service "monit" do
  supports :restart => true
  action :enable
end

# Prepare build task
bash "Build and install monit" do
  cwd monit[:folder]
  code "make clean && make && make install"
  action :nothing
  notifies :restart, resources(:service => "monit")
end

# Configure monit if required, and trigger building
bash "Configure monit" do
  command = "./configure #{monit[:options].join(" ")}"
  cwd monit[:folder]
  code "#{command}"
  not_if "grep '$ #{command}\\W*$' #{monit[:folder]}/config.log"
  notifies :run, resources(:bash => "Build and install monit"), :immediately
end

directory "/etc/monit/conf.d" do
  recursive true
end

template "/etc/monit/monitrc" do
  source "monitrc.erb"
  mode 0600
  owner "root"
  group "root"
  variables :monit => node[:monit]
  notifies :restart, resources(:service => "monit"), :delayed
end

template "/etc/monit/conf.d/mail.monitrc" do
  source "mail.monitrc.erb"
  mode 0600
  owner "root"
  group "root"
  variables :monit => node[:monit]
  notifies :restart, resources(:service => "monit"), :delayed
end

template "/etc/monit/conf.d/http.monitrc" do
  source "http.monitrc.erb"
  mode 0600
  owner "root"
  group "root"
  variables :monit => node[:monit]
  notifies :restart, resources(:service => "monit"), :delayed
end

unless monit[:system][:tests].empty?
  template "/etc/monit/conf.d/system.monitrc" do
    source "system.monitrc.erb"
    mode 0600
    owner "root"
    group "root"
    variables :system => node[:monit][:system]
    notifies :restart, resources(:service => "monit"), :delayed
  end
end

