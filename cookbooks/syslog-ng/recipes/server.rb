include_recipe "syslog-ng::default"

directory "/var/log/remote" do
  owner "root"
  group "adm"
  mode "0700"
end

cookbook_file "/etc/syslog-ng/syslog-ng.conf" do
  source "syslog-ng-server.conf"
  notifies :reload, "service[syslog-ng]", :immediately
end
