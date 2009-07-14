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
remote_file "/etc/init.d/ejabberd" do
  source "ejabberd"
  mode 0755
end

service "ejabberd" do
  supports :restart => true
  action :enable
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
  command = "./configure"
  cwd "#{ejabberd[:folder]}/src"
  code "#{command}"
  not_if "grep '$ #{command}\\W*$' #{ejabberd[:folder]}/src/config.log"
  notifies :run, resources(:bash => "Build and install ejabberd"), :immediately
end

template "/etc/ejabberd/ejabberd.cfg" do
  source "ejabberd.cfg.erb"
  variables(:ejabberd => node[:ejabberd])
  notifies :restart, resources(:service => "ejabberd")
end