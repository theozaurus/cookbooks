if ejabberd[:version] =~ /2\.1/
  default[:ejabberd][:pubsub] = ["flat", "hometree", "pep"]
else
  default[:ejabberd][:pubsub] = ["default", "pep"]
end
