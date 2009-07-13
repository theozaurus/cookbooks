define :mysql_new_database do

  bash "creating database #{params[:name]}" do
    code   "mysql --user=root --password=#{@node[:mysql][:server_root_password]} -e \"CREATE DATABASE #{params[:name]} CHARACTER SET utf8 COLLATE utf8_general_ci;\""
    not_if "mysql --user=root --password=#{@node[:mysql][:server_root_password]} #{params[:name]} -e exit;"
  end
  
end