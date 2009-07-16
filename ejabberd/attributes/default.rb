ejabberd Mash.new unless attribute?("ejabberd")

ejabberd[:version] = "2.0.5" unless ejabberd.has_key?(:version)
ejabberd[:link] = "http://www.process-one.net/downloads/ejabberd/#{ejabberd[:version]}/ejabberd-#{ejabberd[:version]}.tar.gz" unless ejabberd.has_key?(:link)
ejabberd[:destination] = "/tmp" unless ejabberd.has_key?(:destination)
ejabberd[:folder] = "#{ejabberd[:destination]}/ejabberd-#{ejabberd[:version]}" unless ejabberd.has_key?(:folder)

ejabberd[:hosts] = [ hostname ] unless ejabberd.has_key?(:hostname)
ejabberd[:services] = [] unless ejabberd.has_key?(:services)

ejabberd[:boot] = :enable unless ejabberd.has_key?(:boot)

ejabberd[:admins] = [] unless ejabberd.has_key?(:admins)
ejabberd[:admins].each do |admin|
  admin[:host] = ejabberd[:hosts].first unless admin.has_key?(:host)
end

ejabberd[:modules] = recipes.recipes.select{|r| r =~ /\Aejabberd::/}.map{|r| r.gsub(/\Aejabberd::/,"")} unless ejabberd.has_key?(:modules)

ejabberd[:auth_method] = {} unless ejabberd.has_key?(:auth_method)