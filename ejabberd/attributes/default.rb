ejabberd Mash.new unless attribute?("ejabberd")

ejabberd[:version] = "2.0.5" unless ejabberd.has_key?(:version)
ejabberd[:link] = "http://www.process-one.net/downloads/ejabberd/#{ejabberd[:version]}/ejabberd-#{ejabberd[:version]}.tar.gz" unless ejabberd.has_key?(:link)
ejabberd[:destination] = "/tmp" unless ejabberd.has_key?(:destination)
ejabberd[:folder] = "#{ejabberd[:destination]}/ejabberd-#{ejabberd[:version]}" unless ejabberd.has_key?(:folder)