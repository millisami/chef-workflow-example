package "syslog-ng"

service "syslog-ng" do
  supports :reload => true
  action :nothing
end
