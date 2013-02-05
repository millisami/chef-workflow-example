require 'helper'

class TestSyslog < MiniTest::Unit::ProvisionedTestCase
  def self.before_suite
    super
    provision('syslog-server')
  end

  def self.after_suite
    super
    deprovision('syslog-server')
  end

  def test_client_write
    provision('syslog-client', 2, %w[syslog-server])
    wait_for('syslog-client')

    server_ip = get_role_ips('syslog-server').first

    get_role_ips('syslog-client').each do |client_ip|
      ssh_command(client_ip, 'logger test_client_write speaking')
    end

    sleep 1

    # FIXME move to a helper or something.
    # FIXME perform_search should probably do less, this is really expensive.
    client_ips = perform_search(:node, "role:syslog-client").map do |name|
      node = Chef::Node.load(name)
      if node["ec2"]
        node["ec2"]["local_ipv4"]
      else
        nil
      end
    end

    if client_ips.compact.empty?
      client_ips = get_role_ips('syslog-client')
    end

    client_ips.each do |client_ip|
      assert_match(
        /test_client_write speaking/,
        ssh_capture(server_ip, "sudo cat /var/log/remote/#{client_ip}/syslog")
      )
    end
  ensure
    deprovision('syslog-client')
  end
end
