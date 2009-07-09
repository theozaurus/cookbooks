define :mysql_new_user, :password => nil, :host => "localhost", :databases => [] do

  con = "--user=root --password=#{@node[:mysql][:server_root_password]}"

  params[:databases].each do |database|
    bash "granting mysql user #{params[:name]} privileges on #{database}" do
      code "mysql #{con} -e \"GRANT ALL ON #{database}.* TO '#{params[:name]}'@'#{params[:host]}' IDENTIFIED BY '#{params[:password]}';\""
      not_if "mysql -u #{params[:name]} --password=#{params[:password]} #{database} -e exit;"
    end
  end
  
end