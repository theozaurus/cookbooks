monit Mash.new unless attribute?("monit")
monit[:services] = [] unless monit.has_key?(:services)