package "avahi-daemon"

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