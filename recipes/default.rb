remote_file "logstash_package" do
	source "#{node['logstash']['install_zip_url']}"
end

package "logstash_package" do
	action :install
end

bash 'config gist' do
	cwd "/etc/logstash"
	code <<-EOH
	curl -O --user '#{node['logstash']['config_file_gist']['userid']}:#{node['logstash']['config_file_gist']['pwd']}' '#{node['logstash']['config_file_gist']['url']}'
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