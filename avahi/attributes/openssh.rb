avahi Mash.new unless attribute?("avahi")

avahi[:ssh] = Mash.new unless avahi.has_key?(:ssh)
avahi[:ssh][:enabled] = recipe?("openssh") unless avahi[:ssh].has_key?(:enabled)
avahi[:ssh][:port] = 22 unless avahi[:ssh].has_key?(:port)

avahi[:sftp] = Mash.new unless avahi.has_key?(:sftp)
avahi[:sftp][:enabled] = recipe?("openssh") unless avahi[:sftp].has_key?(:enabled)
avahi[:sftp][:port] = 22 unless avahi[:sftp].has_key?(:port)