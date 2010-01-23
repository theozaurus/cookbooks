default[:ejabberd][:version]      = "2.0.5"
default[:ejabberd][:link]         = "http://www.process-one.net/downloads/ejabberd/#{ejabberd[:version]}/ejabberd-#{ejabberd[:version].gsub("-","_")}.tar.gz"
default[:ejabberd][:destination]  = "/usr/local/src"
default[:ejabberd][:folder]       = "#{ejabberd[:destination]}/ejabberd-#{ejabberd[:version].gsub("-","_")}"

if ejabberd[:version] =~ /2\.1/
  default[:ejabberd][:ebin]       = "/lib/ejabberd/ebin"
else
  default[:ejabberd][:ebin]       = "/var/lib/ejabberd/ebin"
end

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

if ejabberd[:auth_method].has_key?(:ldap)
  default[:ejabberd][:auth_method][:ldap][:servers]       = [ fqdn ]
  default[:ejabberd][:auth_method][:ldap][:port]          = 389
  if attribute? :openldap
    default[:ejabberd][:auth_method][:ldap][:base]        = "ou=users,#{openldap[:basedn]}"
    default[:ejabberd][:auth_method][:ldap][:password]    = openldap[:rootpw]
    default[:ejabberd][:auth_method][:ldap][:rootdn]      = "cn=admin,#{openldap[:basedn]}"
  else
    default[:ejabberd][:auth_method][:ldap][:base]        = "dc=example,dc=org"
    default[:ejabberd][:auth_method][:ldap][:password]    = ""
    default[:ejabberd][:auth_method][:ldap][:rootdn]      = ""
  end
  default[:ejabberd][:auth_method][:ldap][:uids]          = '{"cn", "%u"}'
  default[:ejabberd][:auth_method][:ldap][:filter]        = nil
  default[:ejabberd][:auth_method][:ldap][:local_filter]  = nil
end

params = []
params << "--enable-odbc" unless (ejabberd[:modules] & ["odbc", "mod_archive_odbc"]).empty?
default[:ejabberd][:options] = params