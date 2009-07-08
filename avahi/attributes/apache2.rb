avahi Mash.new unless attribute?("avahi")

avahi[:http] = Mash.new unless avahi.has_key?(:http)
avahi[:http][:enabled] = recipe?("apache2") unless avahi[:http].has_key?(:enabled)
avahi[:http][:port] = 80 unless avahi[:http].has_key?(:port)