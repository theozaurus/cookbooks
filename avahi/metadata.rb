maintainer       "Jiva Technology Limited"
maintainer_email "theo@jivatechnology.com"
license          "Apache 2.0"
description      "Installs avahi"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

supports "ubuntu"

%(ssh sftp http).each do |name|
  attribute "avahi/#{name}/enabled",
    :display_name => "#{name} advertised",
    :description => "If set to true will advertise #{name}",
    :type => "boolean"
    
  attribute "avahi/#{name}/port",
    :display_name => "#{name} port",
    :description => "The port #{name} is running on",
    :type => "integer"
end