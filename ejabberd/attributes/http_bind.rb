ejabberd Mash.new unless attribute?("ejabberd")
ejabberd[:http_bind] = {} unless ejabberd.has_key?(:http_bind)
ejabberd[:http_bind][:port] = 5280 unless ejabberd[:http_bind].has_key?(:port)
ejabberd[:http_bind][:tls] = false unless ejabberd[:http_bind].has_key?(:tls)

