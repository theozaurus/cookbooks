include_recipe "java::jre"
include_recipe "iptables"

package "unzip"

jboss = node[:jboss]

user "jboss" do
  home "/home/jboss" # used for ssh keys
  supports :manage_home => true
end

bash "Setup permissions for JBoss" do
  code "chown -R jboss:jboss #{jboss[:folder]}"
  action :nothing
end

bash "Unzip JBoss" do
  cwd jboss[:src]
  code "unzip #{jboss[:file]} -d #{jboss[:unzip]}"
  not_if "test -d #{jboss[:folder]}"
  action :nothing
  notifies :run, resources(:bash => "Setup permissions for JBoss"), :immediately
end

# Downloads jboss
remote_file "/usr/local/src/jboss-#{jboss[:version]}.zip" do
  source   jboss[:link]
  checksum jboss[:sha256]
  notifies :run, resources(:bash => "Unzip JBoss"), :immediately
end

link jboss[:home] do
  to jboss[:folder]
end

template "/etc/init.d/jboss" do
  source "jboss.init.erb"
  mode   0755
  variables :conf => jboss[:conf]
end

template "/etc/profile.d/jboss.sh" do
  mode 0755
  source "jboss.sh.erb"
  variables :home => jboss[:home],
            :conf => jboss[:conf]
end

service "jboss" do
  action [:enable, :start]
end