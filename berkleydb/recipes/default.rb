berkleydb = node[:berkleydb]

# Downloads berkleydb
bash "Download berkleydb" do
  cwd berkleydb[:destination]
  code "curl #{berkleydb[:link]} | tar xz"
  not_if "test -d #{berkleydb[:folder]}"
end

# Prepare build task
bash "Build and install berkleydb" do
  cwd "#{berkleydb[:folder]}/build_unix"
  code "make clean && make && make install && ldconfig"
  action :nothing
end

template "/etc/ld.so.conf.d/libdb.conf" do
  source "libdb.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables :short_version => berkleydb[:short_version]
end

# Configure berkleydb if required, and trigger building
bash "Configure berkleydb" do
  command = "../dist/configure #{berkleydb[:options].join(" ")}"
  cwd "#{berkleydb[:folder]}/build_unix"
  code command
  not_if "grep '$ #{command}\\W*$' #{berkleydb[:folder]}/build_unix/config.log"
  notifies :run, resources(:bash => "Build and install berkleydb"), :immediately
end
