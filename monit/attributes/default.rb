default[:monit][:version]      = "5.0.3"
default[:monit][:link]         = "http://mmonit.com/monit/dist/monit-#{monit[:version]}.tar.gz"
default[:monit][:destination]  = "/usr/local/src"
default[:monit][:folder]       = "#{monit[:destination]}/monit-#{monit[:version]}"
default[:monit][:options]      = ["--sysconfdir=/etc/monit"]

default[:monit][:interval]     = 120

default[:monit][:alerts]       = []

default[:monit][:mailserver][:host]      = "localhost"
default[:monit][:mailserver][:port]      = 25
default[:monit][:mailserver][:username]  = "admin"
default[:monit][:mailserver][:password]  = "password"
default[:monit][:mailserver][:timeout]   = 15
default[:monit][:mailserver][:protocol]  = nil
default[:monit][:mailserver][:hostname]  = nil
default[:monit][:mailserver][:certmd5]   = nil