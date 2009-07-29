include_recipe "java::jre"

package "curl"

air_sdk = node[:air_sdk]

directory air_sdk[:folder] do
  recursive true
end

bash "Download Adobe AIR SDK #{air_sdk[:version]}" do
  cwd air_sdk[:folder]
  code "curl #{air_sdk[:link]} | tar xjo"
  not_if "test \"$(ls -A #{air_sdk[:folder]})\"" # Test air folder isn't empty
end

template "/etc/profile.d/air_sdk.sh" do
  source "air_sdk.sh.erb"
  owner "root"
  group "root"
  mode 0644
  variables :path => air_sdk[:path]
end