s3fs Mash.new unless attribute?("s3fs")

s3fs[:version]     = "r177" unless s3fs.has_key?(:version)
s3fs[:link]        = "http://s3fs.googlecode.com/files/s3fs-#{s3fs[:version]}-source.tar.gz" unless s3fs.has_key?(:link)
s3fs[:destination] = "/usr/local/src" unless s3fs.has_key?(:destination)
s3fs[:folder]      = "#{s3fs[:destination]}/s3fs" unless s3fs.has_key?(:folder)

s3fs[:options]     = [] unless s3fs.has_key?(:options)


unless s3fs.has_key? :password_file
  s3fs[:password_file] = s3fs.has_key?(:access_key) && s3fs.has_key?(:secret_key)
end