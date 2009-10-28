b = node[:backup_manager]

package "backup-manager" do
  action :remove
end

if b[:tarball][:filetype] == "dar"
  package "dar"
end

bash "Remove cron daily task" do
  code "rm /etc/cron.daily/backup-manager"
  only_if "test -f /etc/cron.daily/backup-manager"
end

bash "Build and install backup-manager" do
  cwd b[:folder]
  code "make clean && make && make install"
  action :nothing
end

bash "Download backup-manager" do
  cwd b[:destination]
  code "curl #{b[:link]} | tar xz"
  not_if "test -d #{b[:folder]}"
  notifies :run, resources(:bash => "Build and install backup-manager"), :immediately
end

template "/etc/backup-manager.conf" do
  source "backup-manager.conf.erb"
  owner b[:cron][:user]
  mode 0660
  variables(:b => b)
end

if b[:upload][:method].include?("s3")
  package "libfile-slurp-perl"
  package "libnet-amazon-s3-perl"
  
  aws_s3_bucket b[:upload][:s3][:destination] do
    secret_key b[:upload][:s3][:secret_key]
    access_key b[:upload][:s3][:access_key]
  end
end

cron "backup-manager" do
  mailto  b[:cron][:mailto]
  user    b[:cron][:user]
  minute  b[:cron][:minute]
  hour    b[:cron][:hour]
  day     b[:cron][:day]
  month   b[:cron][:month]
  weekday b[:cron][:weekday]
  command "/usr/sbin/backup-manager"
end