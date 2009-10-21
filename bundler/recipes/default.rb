include_recipe "git"

bash "Download and install bundler" do
  code "git clone git://github.com/wycats/bundler.git && cd bundler && rake install && cd .. && rm -rf bundler"
  not_if "gem specification bundler"
end