define :ssh_known_hosts, :user => nil, :hosts => [] do
  
  home = `cd ~#{params[:user]} && pwd`.strip
  known_hosts = "#{home}/.ssh/known_hosts"
  
  bash "create known_hosts" do
    user params[:user]
    group params[:user]
    code "touch #{known_hosts}"
    not_if "sudo -u #{params[:user]} file #{known_hosts}"
  end
  
  params[:hosts].each do |host|
    bash "adding host #{host}" do
      user params[:user]
      code "ssh #{host} -o StrictHostKeyChecking=no; true"
      not_if "sudo -u #{params[:user]} ssh-keygen -F #{host} | grep #{host}"
    end
  end
end