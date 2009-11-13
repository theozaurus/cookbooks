include_recipe "erlang"
include_recipe "build-essential" 

package "libexpat1-dev"
package "zlib1g-dev"
package "libssl-dev"
package "curl"

ejabberd = node[:ejabberd]

# Downloads ejabberd
bash "Download ejabberd" do
  cwd ejabberd[:destination]
  code "curl #{ejabberd[:link]} | tar xz"
  not_if "test -d #{ejabberd[:folder]}"
end

# Setup SysV
template "/etc/init.d/ejabberd" do
  source "ejabberd.erb"
  variables(:user => node[:ejabberd][:user])
  mode 0755
end

service "ejabberd" do
  supports :restart => true
  action ejabberd[:boot]
end

# Prepare build task
bash "Build and install ejabberd" do
  cwd "#{ejabberd[:folder]}/src"
  code "make clean && make && rm -rf /var/lib/ejabberd/ebin/* && make install"
  action :nothing
  notifies :restart, resources(:service => "ejabberd")
end

# Configure ejabberd if required, and trigger building
bash "Configure ejabberd" do
  command = "./configure #{ejabberd[:options].join(" ")}"
  cwd "#{ejabberd[:folder]}/src"
  code "#{command}"
  not_if "grep '$ #{command}\\W*$' #{ejabberd[:folder]}/src/config.log"
  notifies :run, resources(:bash => "Build and install ejabberd"), :immediately
end

user ejabberd[:user] do
  if ejabberd[:user] == "ejabberd"
    home  "/var/lib/ejabberd"
    shell "/bin/sh"
  end
end

directory "/etc/ejabberd" do
  owner ejabberd[:user]
  group ejabberd[:user]
  mode 0770
end

directory "/var/log/ejabberd" do
  owner ejabberd[:user]
  group ejabberd[:user]
  mode 0770
end

bash "adjust ejabberd owners" do
  code "chown #{ejabberd[:user]}:#{ejabberd[:user]} --recursive /var/lib/ejabberd"
  not_if "test `find /var/lib/ejabberd -not -group #{ejabberd[:user]} -or -not -user #{ejabberd[:user]} | wc -l` = 0"
end

remote_file "/etc/ejabberd/inetrc" do
  source "inetrc"
  mode 0644
end

template "/etc/ejabberd/ejabberd.cfg" do
  source "ejabberd.cfg.erb"
  owner ejabberd[:user]
  group ejabberd[:user]
  mode 0660
  variables(:ejabberd => node[:ejabberd])
  notifies :restart, resources(:service => "ejabberd")
end

file "/sbin/ejabberdctl" do
  mode 0777
end

file "/etc/ejabberd/ejabberdctl.cfg" do
  owner ejabberd[:user]
  group ejabberd[:user]
  mode 0640
end