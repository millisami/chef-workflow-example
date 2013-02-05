module GetIP
  def self.primary_ip(node)
    if node.chef_environment == "vagrant"
      get_interface(node, "eth1").first
    elsif node.chef_environment == "ec2"
      node["ec2"]["local_ipv4"]
    else
      node["ipaddress"]
    end
  end

  def self.get_interface(node, interface, family="inet")
    %W[network interfaces #{interface} addresses].inject(node) do |n, a|
      n[a]
    end.select do |k,v|
      v["family"] == family
    end.flatten.select.with_index { |x, i| i % 2 == 0 }
  rescue
    nil
  end
end
