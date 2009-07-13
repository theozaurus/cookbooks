define :ejabberd_build_module do
  
  include_recipe "ejabberd::modules"
  
  bash "make #{params[:name]}" do
    cwd "/tmp/ejabberd-modules/#{params[:name]}/trunk"
    code "./build.sh"
    creates "/tmp/ejabberd-modules/#{params[:name]}/trunk/ebin/#{params[:name]}.beam"
  end

  bash "install #{params[:name]}" do
    code "cp /tmp/ejabberd-modules/#{params[:name]}/trunk/ebin/*.beam /var/lib/ejabberd/ebin/"
    creates "/var/lib/ejabberd/ebin/#{params[:name]}.beam"
    notifies :restart, resources(:service => "ejabberd")
  end
  
end