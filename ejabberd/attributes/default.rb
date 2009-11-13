default[:ejabberd][:version]      = "2.0.5"
default[:ejabberd][:link]         = "http://www.process-one.net/downloads/ejabberd/#{ejabberd[:version]}/ejabberd-#{ejabberd[:version].gsub("-","_")}.tar.gz"
default[:ejabberd][:destination]  = "/usr/local/src"
default[:ejabberd][:folder]       = "#{ejabberd[:destination]}/ejabberd-#{ejabberd[:version].gsub("-","_")}"

default[:ejabberd][:hosts]        = [ fqdn ]
default[:ejabberd][:services]     = []

default[:ejabberd][:user]         = "ejabberd"

default[:ejabberd][:boot]         = :enable

default[:ejabberd][:admins]       = []
ejabberd[:admins].each do |admin|
  admin[:host] = ejabberd[:hosts].first unless admin.has_key?(:host)
end

default[:ejabberd][:modules]      = recipes.recipes.select{|r| r =~ /\Aejabberd::/}.map{|r| r.gsub(/\Aejabberd::/,"")}
default[:ejabberd][:auth_method]  = {}