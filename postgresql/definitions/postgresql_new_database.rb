define :postgresql_new_database do

  bash "creating database #{params[:name]}" do
    code "sudo -u #{params[:user]} createdb #{params[:user]}"
    # not_if "psql --user=root --password=#{@node[:postgresql][:server_root_password]} #{params[:name]} -e exit;"
  end
  
end