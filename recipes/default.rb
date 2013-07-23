#
# Cookbook Name:: paulapp
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

#######################
#                     #
#   GENERAL CONFIG    #
#                     #
#######################

# uses attributes from /attributes/default.rb
group node[:paulapp][:group]

user node[:paulapp][:user] do
  group node[:paulapp][:group]
  system true
  shell "/bin/bash"
end


#######################
#                     #
#   RECIPES CONFIG    #
#                     #
#######################

# this dependency is included in metadata.rb
include_recipe "apt"
include_recipe "nginx"






#######################
#                     #
#   NGINX CONFIG      #
#                     #
#######################


# amend owner of e.g. /var/data/www/apps/tomatoes
directory node.app.web_dir do
  owner node.user.name
  mode "0755"
  recursive true
end

# create site directory in e.g. /var/data/www/apps/tomatoes
directory "#{node.app.web_dir}/public" do
  owner node.user.name
  mode "0755" 
  recursive true
end

# amend owner of logs dir for site
directory "#{node.app.web_dir}/logs" do
  owner node.user.name
  mode "0755"
  recursive true
end

# add nginx site config 
template "#{node.nginx.dir}/sites-available/#{node.app.name}.conf" do
  source "nginx.conf.erb"
  mode "0644"
end

# create nginx site
nginx_site "#{node.app.name}.conf"

# add some content
template "#{node.app.web_dir}/public/index.html" do
  source "nginxindex.html.erb"
  mode 0755
  owner node.user.name
end






#######################
#                     #
#   APACHE CONFIG     #
#                     #
#######################

# # disable default site
# apache_site "000-default" do
#   enable false
# end

# # create apache config
# template "#{node[:apache][:dir]}/sites-available/myface.conf" do
#   source "apache2.conf.erb"
#   notifies :restart, 'service[apache2]'
# end

# # create document root
# directory "/srv/apache/myface" do
#   action :create
#   recursive true
# end

# # write site
# template "/srv/apache/myface/index.html" do
#   source "index.html.erb"
#   mode "0644" # forget me to create debugging exercise
# end

# # enable myface
# apache_site "myface.conf" do
#   enable true
# end