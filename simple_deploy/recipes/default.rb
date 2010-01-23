simple_deploy = node[:simple_deploy]

directory simple_deploy[:destination] do
  owner simple_deploy[:user]
  group simple_deploy[:user]
  recursive true
end

%w(pids log).each do |d|
  directory "#{simple_deploy[:destination]}/shared/#{d}" do
    owner simple_deploy[:user]
    group simple_deploy[:user]
    recursive true
  end
end

deploy_revision simple_deploy[:destination] do
  repo              simple_deploy[:repo]
  revision          simple_deploy[:revision]
  user              simple_deploy[:user]
  enable_submodules simple_deploy[:enable_submodules]
  restart_command   simple_deploy[:restart_command]
  symlinks          "pids"=>"tmp/pids", "log"=>"log"
end
