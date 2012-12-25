#
# chef-workflow configuration. You can inspect the full set of configured values
# with: `bundle exec rake chef:show_config`
#

#
# This is general configuration -- related to no specific component. Use with
# caution! Most of these settings don't need to be adjusted normally.
#

configure_general do
  # change the location of the chef-workflow generated files
  # workflow_dir File.join(Dir.pwd, '.chef-workflow')
  #
  # change the location of the VM database
  # vm_file '.chef-workflow/vm'
  #
  # change the location of the chef-server prison file (vagrant only)
  # chef_server_prison '.chef-workflow/chef-server'
  #
  # change the type of machine provisioner. You can use a class or :ec2 or
  # :vagrant which map to the appropriate provisioner classes. If you use a
  # custom class, make sure you require it first!
  # machine_provisioner :vagrant 
end

#
# This section configures all things related to vagrant usage
#
configure_vagrant do
  # if you wish to use a different box, supply it as a url here.
  # box_url "http://files.vagrantup.com/precise32.box"
end

configure_knife do
  #
  # you shouldn't need to modify most of these! be sure to 'bundle exec rake
  # chef:show_config' to see the standard values, as well as others that are
  # not listed here.
  #
  # cookbooks_path 'cookbooks'
  # roles_path 'roles'
  # environments_path 'environments'
  # data_bags_path 'data_bags'
  # ssh_user 'vagrant'
  # ssh_password 'vagrant'
  # ssh_identity_file nil
  # use_sudo true
  # test_environment 'vagrant'
  
  # search_index_wait is used for provisioning with VM::KnifeProvisioner. After
  # provisioning, it waits a set value of seconds (60 default) for the metadata
  # to appear in chef's index. If this fails to appear in this time an
  # exception will be thrown. If you have a slow chef server or find yourself
  # hitting this limit a lot, increase this value.
  #
  # search_index_wait 60
  test_recipes [ 'chef-client::service' ]
end

#
# EC2 settings.
#
configure_ec2 do
  #
  # You'll want to heavily edit these if you use the EC2 support. Additionally,
  # it is *strongly advised* to use a separate AWS account for your testing.
  #
  # The access key ID - no default, uses environment if it doesn't exist.
  # access_key_id "my_access_key"
  #
  # The secret access key - no default, uses environment if it doesn't exist.
  # secret_access_key "my_secret"
  #
  # The AMI of provisioned boxes - no default!
  # ami "ami-abcdef123"
  #
  # The instance type of provisioned boxes - no default!
  # instance_type "m1.small"
  #
  # The region where the instances should be allocated - no default!
  # region "us-west-1"
  #
  # The ssh key used for creating machines (you still have to configure knife
  # separately) - no default!
  # ssh_key "test"
  #
  # The security groups to put all machines in; if set to :auto (the default),
  # creates a new one until chef:clean is run.
  # security_groups :auto
  #
  # The open ports in the security groups that are created dynamically. If you
  # need something more complicated, create your own groups by hand and set
  # `security_groups` above to those values. 
  # security_group_open_ports [22, 4000]
end

#
# This is largely important for local VM work. If you're using something like
# EC2 support (which determines its own IPs, for obvious reasons) these
# configuration settings are meaningless.
#
configure_ips do
  # this is treated as a /24, walked incrementally, and with vagrant at least,
  # .1 is spoken for. You'll want 0 as your last octet. Expect this to be less
  # fail in the future. :)
  #
  # subnet "10.10.10.0"
end
