sphinx Mash.new unless attribute?("sphinx")

sphinx[:version] = "0.9.8.1" unless sphinx.has_key?(:version)
sphinx[:link] = "http://www.sphinxsearch.com/downloads/sphinx-#{sphinx[:version]}.tar.gz" unless sphinx.has_key?(:link)
sphinx[:destination] = "/tmp" unless sphinx.has_key?(:destination)
sphinx[:folder] = "#{sphinx[:destination]}/sphinx-#{sphinx[:version]}" unless sphinx.has_key?(:folder)

sphinx[:options] = ["--enable-id64"] unless sphinx.has_key?(:options)