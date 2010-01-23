define :ejabberd_build_module, :module_name => nil do
  
  module_name = params[:module_name] || params[:name]
  
  include_recipe "ejabberd::modules"
  
  bash "make #{params[:name]}" do
    cwd "/tmp/ejabberd-modules/#{params[:name]}/trunk"
    code "./build.sh"
    creates "/tmp/ejabberd-modules/#{params[:name]}/trunk/ebin/#{module_name}.beam"
  end

  bash "install #{params[:name]}" do
    code "cp /tmp/ejabberd-modules/#{params[:name]}/trunk/ebin/*.beam #{node[:ejabberd][:ebin]}"
    creates "#{node[:ejabberd][:ebin]}/#{module_name}.beam"
    notifies :run, resources(:bash => "adjust ejabberd owners")
    notifies :restart, resources(:service => "ejabberd")
  end
  
end