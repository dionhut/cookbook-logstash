include_recipe "java::default"

remote_file "logstash.deb" do
	source "#{node['logstash']['package_url']}"
end

package "logstash.deb" do
	version "#{node['logstash']['version']}"
	action :install
end

curl_usr = "#{node['logstash']['config_file_gist']['userid']}:#{node['logstash']['config_file_gist']['pwd']}"
curl_path = "#{node['logstash']['config_file_gist']['download_url']}"

bash 'config gist' do
	cwd "/etc/logstash/conf.d"
	code <<-EOH
	curl -O --user '#{curl_usr}' '#{curl_path}'
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