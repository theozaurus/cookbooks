default[:ssh][:keys] = []

ssh[:keys].each {|k|
  k[:user]  = "root" unless k[:user]
  k[:hosts] = []     unless k[:hosts]
}