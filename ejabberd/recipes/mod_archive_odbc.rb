include_recipe "ejabberd::mysql"
include_recipe "ejabberd::odbc"
ejabberd_build_module "mod_archive"

# Seed database
mysql_seed "mod_archive_odbc tables" do
  file "/tmp/ejabberd-modules/mod_archive/trunk/src/mod_archive_odbc_mysql.sql"
  database node[:ejabberd][:odbc][:mysql][:database]
  tables ["archive_collections", "archive_messages", "archive_jid_prefs", "archive_global_prefs"]
end