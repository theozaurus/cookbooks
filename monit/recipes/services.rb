services = node[:monit][:services]

services.each do |service|
  template "/etc/monit/conf.d/#{service[:name]}.monitrc" do
    source "service.monitrc.erb"
    mode 0600
    owner "root"
    group "root"
    variables :service => service
    notifies :restart, resources(:service => "monit"), :delayed
  end
end