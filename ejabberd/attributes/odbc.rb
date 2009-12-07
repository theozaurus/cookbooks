ejabberd Mash.new unless attribute?("ejabberd")
ejabberd[:odbc] = {} unless ejabberd.has_key?(:odbc)
ejabberd[:odbc][:mysql] = {} unless ejabberd[:odbc].has_key?(:mysql)
ejabberd[:odbc][:mysql][:host] = "localhost" unless ejabberd[:odbc][:mysql].has_key?(:host)
ejabberd[:odbc][:mysql][:database] = "ejabberd" unless ejabberd[:odbc][:mysql].has_key?(:database)
ejabberd[:odbc][:mysql][:username] = "ejabberd" unless ejabberd[:odbc][:mysql].has_key?(:username)

unless ejabberd[:odbc][:mysql].has_key?(:password)
  password = ""
  chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  20.times { |i| password << chars[rand(chars.size-1)] }
  ejabberd[:odbc][:mysql][:password] = password
end