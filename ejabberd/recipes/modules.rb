include_recipe "subversion"

execute "download ejabberd modules" do
  cwd "/tmp"
  command "svn co http://svn.process-one.net/ejabberd-modules ejabberd-modules"
  creates "/tmp/ejabberd-modules"  
end

execute "setup modules destination" do
  command "mkdir -p /var/lib/ejabberd/ebin"
  creates "/var/lib/ejabberd/ebin"
end