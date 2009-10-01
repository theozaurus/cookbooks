package "avahi-daemon"
package "libnss-mdns"

service "networking" do
  action :nothing
end

remote_file "/etc/nsswitch.conf" do
  source "nsswitch.conf"
  notifies :restart, resources(:service => "networking")
end

service "avahi-daemon" do
  supports :restart => true, :reload => true
  action :enable
end

%w(ssh sftp http).each do |name|
  if node[:avahi][name][:enabled]
    template "/etc/avahi/services/#{name}.service" do
      source "#{name}.service.erb"
      mode 0644
      owner "root"
      group "root"
      variables(
        :port => node[:avahi][name][:port]
      )
      notifies :reload, resources(:service => "avahi-daemon")
    end
  end
  
end