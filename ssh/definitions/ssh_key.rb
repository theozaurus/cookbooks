define :ssh_key, :key => nil, :sort => "private", :user => "root" do
    
  user_home = case params[:user]
  when "root" : "/root"
  else "/home/#{params[:user]}"
  end
    
  directory "#{user_home}/.ssh" do
    owner params[:user]
    group params[:user]
    mode 00700
    recursive true
  end
  
  case params[:sort]
  when "private"
    filename    = params[:name]
    permissions = 00600
  when "public"
    filename = "#{params[:name]}.pub"
    permissions = 00644
  else raise "ssh key sort must be private or public not #{params[:sort]}"
  end
  
  template "#{user_home}/.ssh/#{filename}" do
    source "ssh_key.erb"
    owner params[:user]
    group params[:user]
    mode permissions
    variables :key => params[:key]
  end
  
end
