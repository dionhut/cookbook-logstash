apt_package "#{node['java']['package_name']}" do
	action :install
end

apt_package "logstash" do
	action :install
end

curl_cmd = "curl -O --user '#{node['logstash']['config_file_gist']['userid']}:#{node['logstash']['config_file_gist']['pwd']}' '#{node['logstash']['config_file_gist']['download_url']}'"

bash 'config gist' do
	cwd "/etc/logstash/conf.d"
	code <<-EOH
	#{curl_cmd}
	tar -zxf download
	cd gist*
	mv gistfile1.txt ../logstash.conf
	rm -rf gist*
	rm download
	EOH
end

service "logstash" do
	action :restart
end