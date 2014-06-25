package "#{node['logstash']['install_zip_url']}" do
	action :install
end

bash 'config gist' do
	cwd "/etc/logstash"
	code <<-EOH
	curl -O --user '#{['logstash']['config_file_gist']['userid']}:#{['logstash']['config_file_gist']['pwd']}' '#{['logstash']['config_file_gist']['url']}'
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