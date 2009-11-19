define :ldap_add, :attributes => {} do

  gem_package "ruby-net-ldap"

  ruby_block "Create LDAP entry #{params[:name]} at #{node[:openldap][:server]}" do
    block do
      Gem.clear_paths
      require 'net/ldap'
      
      auth = {:method => :simple, :username => node[:openldap][:rootdn], :password => node[:openldap][:rootpw]}
      Net::LDAP.open(:host => node[:openldap][:server], :port => 389, :auth => auth) do |ldap|
        success = ldap.add( :dn => params[:name], :attributes => params[:attributes] )
        raise "Failed to create LDAP entry #{params[:name]} with #{ldap.get_operation_result.message}" unless success || ldap.get_operation_result.code == 68 # 68 = entry already exists
      end
    end
  end
  
end