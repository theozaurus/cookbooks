default[:backup_manager][:version]        = "0.7.8"
default[:backup_manager][:link]           = "http://www.backup-manager.org/download/backup-manager-#{backup_manager[:version]}.tar.gz"
default[:backup_manager][:destination]    = "/usr/local/src"
default[:backup_manager][:folder]         = "#{backup_manager[:destination]}/backup-manager-#{backup_manager[:version]}"
default[:backup_manager][:options]        = []

default[:backup_manager][:cron][:mailto]  = "root"
default[:backup_manager][:cron][:user]    = "root"
default[:backup_manager][:cron][:minute]  = "0"
default[:backup_manager][:cron][:hour]    = "3"
default[:backup_manager][:cron][:day]     = "*"
default[:backup_manager][:cron][:month]   = "*"
default[:backup_manager][:cron][:weekday] = "*"

if defined?( :ec2 )
  default[:backup_manager][:repository_root]    = "/mnt/archives"  
else
  default[:backup_manager][:repository_root]    = "/var/archives"
end
default[:backup_manager][:temp_dir]           = "/tmp"
default[:backup_manager][:repository_secure]  = true

default[:backup_manager][:repository_user]    = backup_manager[:cron][:user]
default[:backup_manager][:repository_group]   = backup_manager[:cron][:user]

default[:backup_manager][:repository_chmod]           = "770"
default[:backup_manager][:archive_chmod]              = "660"
default[:backup_manager][:archive_ttl]                = "5"
default[:backup_manager][:repository_recursivepurge]  = false
default[:backup_manager][:archive_purgedups]          = true
default[:backup_manager][:archive_prefix]             = hostname
default[:backup_manager][:archive_strictpurge]        = true
default[:backup_manager][:archive_nice_level]         = "10"
default[:backup_manager][:archive_method]             = ["tarball"]
default[:backup_manager][:encryption_method]          = false
default[:backup_manager][:encryption_recipient]       = nil

default[:backup_manager][:upload][:method]      = []
default[:backup_manager][:upload][:hosts]       = []
default[:backup_manager][:upload][:destination] = nil

default[:backup_manager][:upload][:ssh][:user]          = nil
default[:backup_manager][:upload][:ssh][:key]           = nil
default[:backup_manager][:upload][:ssh][:hosts]         = []
default[:backup_manager][:upload][:ssh][:port]          = nil
default[:backup_manager][:upload][:ssh][:destination]   = nil
default[:backup_manager][:upload][:ssh][:purge]         = true
default[:backup_manager][:upload][:ssh][:ttl]           = nil
default[:backup_manager][:upload][:ssh][:gpg_recipient] = nil

default[:backup_manager][:upload][:ftp][:secure]      = false
default[:backup_manager][:upload][:ftp][:passive]     = true
default[:backup_manager][:upload][:ftp][:user]        = nil
default[:backup_manager][:upload][:ftp][:password]    = nil
default[:backup_manager][:upload][:ftp][:hosts]       = []
default[:backup_manager][:upload][:ftp][:purge]       = true
default[:backup_manager][:upload][:ftp][:ttl]         = nil
default[:backup_manager][:upload][:ftp][:destination] = nil

default[:backup_manager][:upload][:s3][:destination]  = fqdn
default[:backup_manager][:upload][:s3][:access_key]   = nil
default[:backup_manager][:upload][:s3][:secret_key]   = nil
default[:backup_manager][:upload][:s3][:purge]        = false

default[:backup_manager][:upload][:rsync][:directories]   = []
default[:backup_manager][:upload][:rsync][:destination]   = nil
default[:backup_manager][:upload][:rsync][:hosts]         = []
default[:backup_manager][:upload][:rsync][:dumpsymlinks]  = false

default[:backup_manager][:tarball][:nameformat]           = "long"
if backup_manager[:upload][:method].include?("s3")
  # The CPAN module Net::Amazon::S3 has a bug which means you need to allocate the same amount of memory as the archive
  # Thus dar format and a slicesize of 100M is used to make sure the server does not run out of memory
  default[:backup_manager][:tarball][:filetype]           = "dar"
  default[:backup_manager][:tarball][:slicesize]          = "100M"
else
  default[:backup_manager][:tarball][:filetype]           = "tar.gz"
  default[:backup_manager][:tarball][:slicesize]          = "1000M"
end
default[:backup_manager][:tarball][:over_ssh]             = false
default[:backup_manager][:tarball][:dumpsymlinks]         = false
default[:backup_manager][:tarball][:directories]          = ["/etc", "/home"]
default[:backup_manager][:tarball][:blacklist]            = [backup_manager[:repository_root]]
default[:backup_manager][:tarball][:extra_options]        = nil
default[:backup_manager][:tarball][:inc_masterdatetype]   = "weekly"
default[:backup_manager][:tarball][:inc_masterdatevalue]  = 1

default[:backup_manager][:mysql][:databases]  = ["__ALL__"]
default[:backup_manager][:mysql][:safedumps]  = true
default[:backup_manager][:mysql][:adminlogin] = "root"
default[:backup_manager][:mysql][:adminpass]  = mysql[:server_root_password]
default[:backup_manager][:mysql][:host]       = mysql[:bind_address] || "localhost"
default[:backup_manager][:mysql][:port]       = 3306
default[:backup_manager][:mysql][:filetype]   = "bzip2"

default[:backup_manager][:svn][:repositories] = []
default[:backup_manager][:svn][:compresswith] = "bzip2"

default[:backup_manager][:burning][:method]     = nil
default[:backup_manager][:burning][:chkmd5]     = false
default[:backup_manager][:burning][:device]     = nil
default[:backup_manager][:burning][:devforced]  = nil
default[:backup_manager][:burning][:iso_flags]  = "-R -J"

default[:backup_manager][:burning][:maxsize]    = nil

default[:backup_manager][:logger]               = true
default[:backup_manager][:logger_facility]      = "user"
default[:backup_manager][:pre_backup_command]   = nil
default[:backup_manager][:post_backup_command]  = nil

