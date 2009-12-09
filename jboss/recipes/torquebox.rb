include_recipe "jboss"
include_recipe "jruby"
include_recipe "git"
include_recipe "ssh::keys"

jboss     = node[:jboss]
torquebox = jboss[:torquebox]

gem_package "bundler" do
  gem_binary "jgem"
end

remote_file "#{jboss[:deployers]}/#{torquebox[:file]}" do
  owner "jboss"
  group "jboss"
  source torquebox[:link]
  mode "0644"
  checksum torquebox[:sha]
end

directory "/srv/jboss/#{torquebox[:name]}" do
  owner "jboss"
  group "jboss"
end

template "#{jboss[:home]}/server/#{jboss[:conf]}/deploy/#{torquebox[:name]}-rack.yml" do
  source "rack.yml.erb"
  owner "jboss"
  group "jboss"
  variables :rack_root => "/srv/jboss/#{torquebox[:name]}/current", 
            :rack_env  => "production",
            :host      => torquebox[:host],
            :context   => torquebox[:context]
end

deploy_revision "/srv/jboss/#{torquebox[:name]}" do
  repo              torquebox[:repo]
  revision          torquebox[:revision]
  user              "jboss"
  enable_submodules true
  restart_command   "touch #{jboss[:home]}/server/#{jboss[:conf]}/deploy/#{torquebox[:name]}-rack.yml"
end