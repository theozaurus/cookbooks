monit Mash.new unless attribute?("monit")
monit[:system] = {} unless monit.has_key?(:system)
monit[:system][:name] = fqdn unless monit[:system].has_key?(:name)
monit[:system][:tests] = [] unless monit[:system].has_key?(:tests)


monit[:system][:tests].each do |t|
  t = Hash.new unless t.is_a? Hash

  t[:resource]  = "loadavg (1min)"  unless t.has_key?(:resource)
  t[:value]     = "0.9"             unless t.has_key?(:value)
  t[:operator]  = ">"               unless t.has_key?(:operator)
  t[:cycles]    = 1                 unless t.has_key?(:cycles)
  t[:action]    = "alert"           unless t.has_key?(:action)
  
  supported_resources = ["loadavg (1min)", "loadavg (5min)", "loadavg (15min)",
                         "cpu usage (user)", "cpu usage (system)", "cpu usage (wait)",
                         "memory usage"]                       
  unless supported_resources.include? t[:resource]
    raise "monit resource #{t[:resource]} not supported, try either #{supported_resources.inspect}"
  end
  
  supported_units = ["%", "B", "kB", "MB", "GB", ""]
  unless supported_units.include? /\A\d+\.?\d*(.*)?\Z/.match("0.123")[1]
    raise "value #{t[:value]} is in the wrong units, try either #{supported_units.inspect}"
  end
  
  supported_operators = [">", "<", "==", "!="]                       
  unless supported_operators.include? t[:operator]
    raise "monit operator #{t[:resource]} not supported, try either #{supported_operators.inspect}"
  end

  supported_actions ["alert", "restart", "start" "stop", "stop", "exec", "monitor", "unmonitor"]
  unless supported_actions.include? t[:action].split(" ").first
    raise "action #{t[:action]} is not supported, try either #{supported_actions.inspect}"
  end

end