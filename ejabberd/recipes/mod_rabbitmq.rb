include_recipe "rabbitmq"
include_recipe "ejabberd"
include_recipe "git"

ejabberd = node[:ejabberd]

bash "download rabbitmq-xmpp" do
  cwd "/tmp"
  code "git clone git://github.com/theoooo/rabbitmq-xmpp.git"
  creates "/tmp/rabbitmq-xmpp"
end

directory "/tmp/rabbitmq-xmpp/ebin"

bash "make rabbitmq-xmpp" do
  cwd "/tmp/rabbitmq-xmpp"
  code "erlc -W -I #{ejabberd[:folder]}/src -o ebin src/mod_rabbitmq.erl"
  creates "/tmp/rabbitmq-xmpp/ebin/mod_rabbitmq.beam"
end

bash "install rabbitmq-xmpp" do
  code "cp /tmp/rabbitmq-xmpp/ebin/*.beam #{node[:ejabberd][:ebin]}/"
  creates "#{node[:ejabberd][:ebin]}/mod_rabbitmq.beam"
  notifies :run, resources(:bash => "adjust ejabberd owners")
  notifies :stop, resources(:service => "rabbitmq-server"), :immediately
  notifies :disable, resources(:service => "rabbitmq-server"), :immediately
  notifies :restart, resources(:service => "ejabberd")
end

