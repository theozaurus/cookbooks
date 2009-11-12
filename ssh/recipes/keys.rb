# We need to go from the structure 
#
# [{:name => "foo", :private_key => "adfssd", :public_key => "a", :users => ["root","bob"], :hosts => ["foo.bar", "bar.baz"]}]
#
# To:
#
# {
#   "root" => [{:name => "foo", :private_key => "adfssd", :public_key => "a", :hosts => ["foo.bar", "bar.baz"]}],
#   "bob"  => [{:name => "foo", :private_key => "adfssd", :public_key => "a", :hosts => ["foo.bar", "bar.baz"]}],
# }

users = {}
node[:ssh][:keys].each do |k|
  
  short_key = k.dup
  short_key.delete(:users).each do |u|
    ( users[u] ||= [] ) << short_key
  end
  
end
  
users.each do |u,keys|
  
  user_home = case u
  when "root" : "/root"
  else "/home/#{u}"
  end
  
  directory "#{user_home}/.ssh" do
    owner u
    group u
    mode 0700
    recursive true
  end
  
  keys.each do |k|
    ssh_key k[:name] do
      user u
      key  k[:private_key]
      sort "private"
    end

    ssh_key k[:name] do
      user u
      key  k[:public_key]
      sort "public"
    end
  end
  
  template "#{user_home}/.ssh/config" do
    source "config.erb"
    variables :keys => keys
    owner u
    group u
    mode 0600
  end
  
end