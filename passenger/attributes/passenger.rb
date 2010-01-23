default[:passenger][:version]               = "2.2.5"
default[:passenger][:root_path]             = "#{languages[:ruby][:gems_dir]}/gems/passenger-#{passenger[:version]}"
default[:passenger][:module_path]           = "#{passenger[:root_path]}/ext/apache2/mod_passenger.so"
default[:passenger][:pool_idle_time]        = 0
default[:passenger][:max_instances_per_app] = 4