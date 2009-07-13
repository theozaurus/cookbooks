include_recipe "erlang"
include_recipe "build-essential" 

remote_file "/tmp/rabbitmq-server_1.4.0-1_all.deb" do
  source "http://www.rabbitmq.com/releases/rabbitmq-server/v1.4.0/rabbitmq-server_1.4.0-1_all.deb"
  mode 0644
end

bash "install-rabbitmq" do
  code "dpkg --install /tmp/rabbitmq-server_1.4.0-1_all.deb"
  not_if "dpkg-query -s rabbitmq-server"
end

service "rabbitmq-server" do
  supports :restart => true, :reload => true
end