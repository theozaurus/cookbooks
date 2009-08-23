package "ssmtp"

template "/etc/ssmtp/ssmtp.conf" do
  source "ssmtp.conf.erb"
  variables :ssmtp => node[:ssmtp]
end