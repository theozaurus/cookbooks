berkleydb Mash.new unless attribute?("berkleydb")

berkleydb[:version] = "4.7.25" unless berkleydb.has_key?(:version)
berkleydb[:short_version] = berkleydb[:version].split(".")[0..1].join(".") unless berkleydb.has_key?(:short_version)
berkleydb[:link] = "http://download.oracle.com/berkeley-db/db-#{berkleydb[:version]}.tar.gz" unless berkleydb.has_key?(:link)
berkleydb[:destination] = "/tmp" unless berkleydb.has_key?(:destination)
berkleydb[:folder] = "#{berkleydb[:destination]}/db-#{berkleydb[:version]}" unless berkleydb.has_key?(:folder)

berkleydb[:options] = [] unless berkleydb.has_key?(:berkleydb)