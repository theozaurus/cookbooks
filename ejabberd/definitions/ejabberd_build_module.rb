define :ejabberd_build_module, :module_name => nil do
  
  module_name = params[:module_name] || params[:name]
  
  include_recipe "ejabberd::modules"
  
  bash "make #{params[:name]}" do
    cwd "/tmp/ejabberd-modules/#{params[:name]}/trunk"
    code "./build.sh"
    creates "/tmp/ejabberd-modules/#{params[:name]}/trunk/ebin/#{module_name}.beam"
  end

  bash "install #{params[:name]}" do
    code "cp /tmp/ejabberd-modules/#{params[:name]}/trunk/ebin/*.beam /var/lib/ejabberd/ebin/"
    creates "/var/lib/ejabberd/ebin/#{module_name}.beam"
    notifies :restart, resources(:service => "ejabberd")
  end
  
end