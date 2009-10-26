s3fs Mash.new unless attribute?("s3fs")

s3fs[:bucket] = fqdn          unless s3fs.has_key?(:bucket)
s3fs[:mount]  = "/mnt/backup" unless s3fs.has_key?(:mount)
