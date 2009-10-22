package "curl"

sphinx = node[:sphinx]

bash "Download sphinx" do
  cwd sphinx[:destination]
  code "curl #{sphinx[:link]} | tar xz"
  not_if "test -d #{sphinx[:folder]}"
end

# Prepare build task
bash "Build and install sphinx" do
  cwd "#{sphinx[:folder]}/src"
  code "make clean && make && make install"
  action :nothing
end

# Configure ejabberd if required, and trigger building
bash "Configure sphinx" do
  command = "./configure #{sphinx[:options].join(" ")}"
  cwd sphinx[:folder]
  code "#{command}"
  not_if "grep '$ #{command}\\W*$' #{sphinx[:folder]}/config.log"
  notifies :run, resources(:bash => "Build and install sphinx"), :immediately
end