rack_app Mash.new unless attribute?("rack_app")

rack_app[:name] = "website" unless rack_app.has_key?(:name)
rack_app[:user] = rack_app[:name] unless rack_app.has_key?(:user)
rack_app[:domain] = fqdn unless rack_app.has_key?(:domain)
rack_app[:aliases] = [] unless rack_app.has_key?(:aliases)
rack_app[:path] = "/home/#{rack_app[:user]}/#{rack_app[:name]}" unless rack_app.has_key?(:path)
rack_app[:ssh_keys] = [] unless rack_app.has_key?(:ssh_keys)

rack_app[:rails] = {} unless rack_app.has_key?(:rails)
rack_app[:rails][:environment]  = "production" unless rack_app[:rails].has_key?(:environment)

rack_app[:database] = {} unless rack_app.has_key?(:database)
rack_app[:database][:name] = "#{rack_app[:name]}_#{rack_app[:rails][:environment]}" unless rack_app[:database].has_key?(:name)
rack_app[:database][:user] = rack_app[:name] unless rack_app[:database].has_key?(:user)

unless rack_app[:database].has_key?(:password)
  password = ""
  chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  20.times { |i| password << chars[rand(chars.size-1)] }
  rack_app[:database][:password] = password 
end