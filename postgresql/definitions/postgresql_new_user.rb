define :postgresql_new_user do

  bash "creating user #{params[:name]}" do
    code "sudo -u postgres createuser --superuser #{params[:name]}"
    # not_if "mysql -u #{params[:name]} --password=#{params[:password]} #{database} -e exit;"
  end
  
end