define :vlad_setup, :path => nil, :owner => "root", :group => "root" do
  include_recipe "vlad"

  directory params[:path] do
    owner params[:owner]
    group params[:group]
    mode 0755
  end
  
  # after chef-174 fixed, change mode to 2775
  %w{ releases shared scm }.each do |dir|
    directory "#{params[:path]}/#{dir}" do
      owner params[:owner]
      group params[:group]
      mode 0775
    end
  end
  
  %w{ pids log system }.each do |dir|
    directory "#{params[:path]}/shared/#{dir}" do
      owner params[:owner]
      group params[:group]
      mode 0775
    end
  end  
  
end
