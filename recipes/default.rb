package "#{node['logstash']['install_zip_url']}" do
	action :install
end

template "/etc/logstash/logstash.conf" do
  source 'logstash.conf.erb'
  cookbook 'logstash'
  variables(
    :inputs       => node['kibana3']['inputs'],
    :filters      => node['kibana3']['filters'],
    :outputs      => node['kibana3']['outputs'],
  )
  mode "0755"
end

service "logstash" do
	action :restart
end