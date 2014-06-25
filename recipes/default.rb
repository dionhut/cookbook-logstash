apt_package "#{node['java']['package_name']}" do
	action :install
end

apt_package "logstash" do
	action :install
end

bash 'config gist' do
	cwd "/etc/logstash/conf.d"
	code <<-EOH
	curl -O --user '#{node['logstash']['config_file_gist']['userid']}:#{node['logstash']['config_file_gist']['pwd']}' '#{node['logstash']['config_file_gist']['download_url']}'
	tar -zxf download
	cd gist*
	mv gistfile1.txt ../logstash.conf
	rm -rf gist*
	rm download
	EOH
  	command ""
end

service "logstash" do
	action :restart
end