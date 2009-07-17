define :ssh_authorized_keys, :user => nil, :keys => [] do

  directory "#{params[:user]}/.ssh" do
    home = `cd ~#{params[:user]} && pwd`.strip
    authorized_keys = "#{home}/.ssh/authorized_keys"
    
    path "#{home}/.ssh"
    owner params[:user]
    group params[:user]
    mode 0700
  end
  
  params[:keys].each do |key|
    bash "adding key '#{key.split(" ").last}'" do
      home = `cd ~#{params[:user]} && pwd`.strip
      authorized_keys = "#{home}/.ssh/authorized_keys"
      
      code "echo '#{key}' >> #{authorized_keys}"
      not_if "grep '#{key}' #{authorized_keys}"
    end
  end
  
  bash "adjust permissions of authorized_keys file for #{params[:user]}" do
    home = `cd ~#{params[:user]} && pwd`.strip
    authorized_keys = "#{home}/.ssh/authorized_keys"
    
    code "chmod 600 #{authorized_keys} && chown #{params[:user]}:#{params[:user]} #{authorized_keys}"
    not_if "test `find #{home}/.ssh -maxdepth 1 -user #{params[:user]} -group #{params[:user]} -name authorized_keys -perm 600 | wc -l` = 1"
  end
    
end