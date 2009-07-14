include_recipe "ejabberd"
include_recipe "ejabberd::mysql"

ejabberd = node[:ejabberd]

# Create database
mysql_new_database ejabberd[:odbc][:mysql][:database]

# Setup database user
mysql_new_user ejabberd[:odbc][:mysql][:username] do
  password  ejabberd[:odbc][:mysql][:password]
  databases [ejabberd[:odbc][:mysql][:database]]
end
