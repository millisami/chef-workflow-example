include_recipe "syslog-ng::default"

syslog_servers = 
  search(:node, %Q[chef_environment:#{node.chef_environment} AND roles:"syslog-server"]).
    map do |this_node|
      GetIP.primary_ip(this_node)
    end.compact

unless syslog_servers.empty? or node.roles.include?("syslog-server")
  template "/etc/syslog-ng/syslog-ng.conf" do
    source "syslog-ng-client.conf.erb"
    variables(:syslog_servers => syslog_servers)
    notifies :reload, "service[syslog-ng]", :immediately
  end
end
