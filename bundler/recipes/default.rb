include_recipe "git"

bash "Download and install bundler" do
  cwd "/tmp"
  code "git clone git://github.com/wycats/bundler.git && cd bundler && rake package && gem install pkg/bundler-0.7.0.pre.gem --no-rdoc --no-ri && cd .. && rm -rf bundler"
  not_if "gem specification bundler"
end