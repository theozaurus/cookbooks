monit Mash.new unless attribute?("monit")

monit[:version] = "5.0.3" unless monit.has_key?(:version)
monit[:link] = "http://mmonit.com/monit/dist/monit-#{monit[:version]}.tar.gz" unless monit.has_key?(:link)
monit[:destination] = "/tmp" unless monit.has_key?(:destination)
monit[:folder] = "#{monit[:destination]}/monit-#{monit[:version]}" unless monit.has_key?(:folder)
monit[:options] = ["--sysconfdir=/etc/monit"] unless monit.has_key?(:options)

monit[:interval] = 120 unless monit.has_key?(:interval)

monit[:alerts] = [] unless monit.has_key?(:alerts)

monit[:mailserver] = {} unless monit.has_key?(:mailserver)
monit[:mailserver][:host] = "localhost" unless monit[:mailserver].has_key?(:host)
monit[:mailserver][:port] = 25 unless monit[:mailserver].has_key?(:port)
monit[:mailserver][:username] = "admin" unless monit[:mailserver].has_key?(:username)
monit[:mailserver][:password] = "password" unless monit[:mailserver].has_key?(:password)
monit[:mailserver][:timeout] = 15 unless monit[:mailserver].has_key?(:timeout)
