memcachedb Mash.new unless attribute?("memcachedb")

memcachedb[:version] = "1.2.0" unless memcachedb.has_key?(:version)
memcachedb[:link] = "http://memcachedb.googlecode.com/files/memcachedb-#{memcachedb[:version]}.tar.gz" unless memcachedb.has_key?(:link)
memcachedb[:destination] = "/tmp" unless memcachedb.has_key?(:destination)
memcachedb[:folder] = "#{memcachedb[:destination]}/memcachedb-#{memcachedb[:version]}" unless memcachedb.has_key?(:folder)

memcachedb[:options] = [] unless memcachedb.has_key?(:memcachedb)