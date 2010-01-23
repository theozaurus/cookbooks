include_recipe "s3fs"

s3fs = node[:s3fs]

aws_s3_bucket s3fs[:bucket] do
  secret_key s3fs[:secret_key]
  access_key s3fs[:access_key]
end