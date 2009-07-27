define :ssh_authorized_keys, :user => nil, :keys => [] do

  bash "create #{params[:user]}/.ssh" do
    code "mkdir ~#{params[:user]}/.ssh"
    not_if "test -d ~#{params[:user]}/.ssh"
  end
  
  bash "setup permissions on #{params[:user]}/.ssh" do
    code "chmod 0700 ~#{params[:user]}/.ssh && chown #{params[:user]}:#{params[:user]} ~#{params[:user]}/.ssh"
    not_if "test `find ~#{params[:user]} -maxdepth 1 -type d -perm 0700 -name .ssh -user #{params[:user]} -group #{params[:user]} | wc -l` = 1"
  end

  params[:keys].each do |key|
    bash "adding key '#{key.split(" ").last}'" do
      code "echo '#{key}' >> ~#{params[:user]}/.ssh/authorized_keys"
      not_if "grep '#{key}' ~#{params[:user]}/.ssh/authorized_keys"
    end
  end
  
  bash "adjust permissions of authorized_keys file for #{params[:user]}" do
    code "chmod 600 ~#{params[:user]}/.ssh/authorized_keys && chown #{params[:user]}:#{params[:user]} ~#{params[:user]}/.ssh/authorized_keys"
    not_if "test `find ~#{params[:user]}/.ssh -maxdepth 1 -user #{params[:user]} -group #{params[:user]} -name authorized_keys -perm 600 | wc -l` = 1"
  end
    
end