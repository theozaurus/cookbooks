execute "update-java-alternatives" do
  command "update-java-alternatives -s java-6-sun"
  only_if do platform?("ubuntu", "debian") end
  ignore_failure true
  returns 1
  action :nothing
end

package "sun-java6-jre" do
  action :install
  response_file "java.seed"
  notifies :run, resources(:execute => "update-java-alternatives"), :immediately
end