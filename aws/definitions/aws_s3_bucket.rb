define :aws_s3_bucket, :secret_key => nil, :access_key => nil do

  gem_package "aws-s3"

  ruby_block "Create S3 Bucket #{params[:name]}" do
    block do
      Gem.clear_paths
      require "aws/s3"
      AWS::S3::Base.establish_connection!(:access_key_id => params[:access_key], :secret_access_key => params[:secret_key])
      AWS::S3::Bucket.create(params[:name]) unless AWS::S3::Service.buckets.map{|b| b.name}.include? params[:name]
    end
  end
  
end