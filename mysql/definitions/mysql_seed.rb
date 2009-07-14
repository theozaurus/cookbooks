define :mysql_seed, :file => nil, :database => nil, :tables => [] do

  con = "--user=root --password=#{@node[:mysql][:server_root_password]}"
  check = params[:tables].map{|table| "mysql #{con} #{params[:database]} -e \"SELECT * FROM #{table};\"" }.join(" && ")

  bash "populating #{params[:database]} with #{params[:file]}" do
    code "mysql #{con} < #{params[:file]}"
    not_if check
  end
  
end