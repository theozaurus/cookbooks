default[:jboss][:version]      = "5.1.0.GA"
default[:jboss][:link]         = "http://downloads.sourceforge.net/project/jboss/JBoss/JBoss-#{jboss[:version]}/jboss-#{jboss[:version]}.zip"
default[:jboss][:src]          = "/usr/local/src"
default[:jboss][:unzip]        = "/usr/local"
default[:jboss][:file]         = "#{jboss[:src]}/jboss-#{jboss[:version]}.zip"
default[:jboss][:folder]       = "#{jboss[:unzip]}/jboss-#{jboss[:version]}"
default[:jboss][:sha256]       = "be93bcb8f1ff03d7e64c98f2160a2415602268d84f44fb78cddb26303a8cbd3f"

default[:jboss][:home]         = "/usr/local/jboss"
default[:jboss][:conf]         = "web"
default[:jboss][:deployers]    = "#{jboss[:home]}/server/#{jboss[:conf]}/deployers"


default[:jboss][:torquebox][:version]     = "1.0.0.Beta18"
default[:jboss][:torquebox][:file]        = "torquebox-core-#{jboss[:torquebox][:version]}-deployer.jar"
default[:jboss][:torquebox][:link]        = "http://repository.torquebox.org/maven2/releases/org/torquebox/torquebox-core/#{jboss[:torquebox][:version]}/#{jboss[:torquebox][:file]}"
default[:jboss][:torquebox][:sha]         = "ee1108e12ed32e09e2590d1a4da38b8581ce8cca209694c361aa8e0d538fbede"

default[:jboss][:torquebox][:repo]        = nil
default[:jboss][:torquebox][:revision]    = "HEAD"

default[:jboss][:torquebox][:host]        = fqdn
default[:jboss][:torquebox][:context]     = "/"