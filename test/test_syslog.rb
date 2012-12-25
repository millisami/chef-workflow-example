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
    provision('syslog-client', 1, %w[syslog-server])
    wait_for('syslog-client')

    client_ip = get_role_ips('syslog-client').first
    server_ip = get_role_ips('syslog-server').first

    ssh_command(client_ip, 'logger test_client_write speaking')

    assert_match(
      /test_client_write speaking/,
      ssh_capture(server_ip, "sudo cat /var/log/remote/#{client_ip}/syslog")
    )
  ensure
    deprovision('syslog-client')
  end
end
