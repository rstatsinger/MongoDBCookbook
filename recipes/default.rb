#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

user 'mongo' do
	home '/opt/mongodb'
end

group 'mongo' do
	members 'mongo'
end

directory '/opt/mongodb' do
	group 'mongo'
  	mode '0775'
 	not_if do
 		File.exist?('/opt/mongodb')
 	end
end

# package 'mongo-db-3.4'

# template for the mongo yum repo

template '/etc/yum.repos.d/mongodb-org-3.4.repo' do
	source 'mongoYumRepo.erb'
	owner 'mongo'
#   	notifies :restart, 'service[mongod ]',:immediate
end

# template for mongod.conf - future

# template '/etc/mongod.conf' do
# 	source 'mongoConf.erb'
# 	owner 'mongo'
#   	notifies :restart, 'service[mongod ]',:immediate
# end

# execute sudo yum install -y mongodb-org

execute 'sudo yum install -y mongodb-org' do
end


execute 'chgrp -R mongo /opt/mondogb' do
 	only_if { Etc.getgrgid(File.stat('/opt/mongodb').gid).name != 'mongo' }
end

execute 'chmod ug+rwx /opt/mongodb' do
  	# only_if { (File.stat('/opt/mongodb').mode & 0070) != 0 }

end

# execute 'systemctl daemon-reload'
execute 'daemonReload' do
	command 'systemctl daemon-reload'
end

# subscribes properties for state changes if needed

service 'mongod' do
	action [:start, :enable]
	# subscribes :restart, 'template[/etc/mongod.conf]', :immediate
end





