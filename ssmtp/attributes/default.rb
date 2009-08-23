ssmtp Mash.new unless attribute?("ssmtp")
ssmtp[:hostname]   = fqdn unless ssmtp.has_key?(:hostname)
ssmtp[:authmethod] = "CRAM-MD5" unless ssmtp.has_key?(:authmethod)
ssmtp[:fromlineoverride] = "YES" unless ssmtp.has_key?(:fromlineoverride)