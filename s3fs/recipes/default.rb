%w(build-essential libcurl4-openssl-dev libxml2-dev libfuse-dev).each{|p| package p}

s3fs = node[:s3fs]

bash "Download s3fs" do
  cwd s3fs[:destination]
  code "curl #{s3fs[:link]} | tar xz"
  not_if "test -d #{s3fs[:folder]}"
end

bash "Build and install s3fs" do
  cwd "#{s3fs[:folder]}"
  code "make clean && make && make install"
  not_if "which s3fs"
end


if s3fs[:password_file]
  template "/etc/passwd-s3fs" do
    source "passwd-s3fs.erb"
    mode 0600
    variables :secret_key => s3fs[:secret_key],
              :access_key => s3fs[:access_key]
  end
end

if @node[:os_version] == "2.6.21.7-2.fc8xen-ec2-v1.0"
  bash "Modprobe fuse" do
    code "modprobe fuse"
    action :nothing
  end
  
  bash "Run depmod" do
    code "depmod"
    action :nothing
    notifies :run, resources(:bash => "Modprobe fuse"), :immediately
  end
  
  directory "/lib/modules/#{@node[:os_version]}/kernel/fs/fuse" do
    recursive true
  end
  
  remote_file "/lib/modules/#{@node[:os_version]}/kernel/fs/fuse/fuse.ko" do
    source "fuse.ko"
    mode 0644
    notifies :run, resources(:bash => "Run depmod"), :immediately
  end
end