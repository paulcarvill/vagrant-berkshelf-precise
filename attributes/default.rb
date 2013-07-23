default[:paulapp][:user] = "paulapp"
default[:paulapp][:group] = "paulapp"

default[:app][:name] = "tomatoes"
default[:app][:web_dir] = "/var/data/www/apps/tomatoes"

default[:user][:name] = "vagrant"
 
default[:nginx][:version] = "1.2.3"
default[:nginx][:default_site_enabled] = "true"
default[:nginx][:source][:modules] = ["http_gzip_static_module", "http_ssl_module"]

default[:run_list] = ["recipe[nginx::source]", "recipe[tomatoes]"]