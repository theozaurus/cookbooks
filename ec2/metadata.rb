maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Manage EC2 metadata as attributes"
version           "0.8"

attribute "ec2_metadata",
  :display_name => "EC2 Metadata",
  :description => "Retrieve EC2 instance metadata"