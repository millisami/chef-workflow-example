#
# Hello!
#
# I also use this repository to test chef-workflow itself. Yes, it's weird.
#
# You shouldn't need to change anything. If you want to add dependencies, add
# them anywhere, it shouldn't change anything, presuming you're not using the
# environment variables listed here.
#
# If you want some more explanation, check out battery.sh.
#

source :rubygems

possibly_local = %w[
  chef-workflow
  chef-workflow-tasklib
  chef-workflow-testlib
]

if ENV["LOCAL"]
  possibly_local.each do |gem_name|
    gem gem_name, :path => "/Users/erikh/repos/cw/#{gem_name}"
  end
else
  possibly_local.each do |gem_name|
    gem gem_name
  end
end

if ENV["CHEF_VERSION"]
  if ENV["CHEF_VERSION"] < "10.16.4"
    gem 'moneta', '~> 0.6.0'
  end
  gem 'chef', ENV["CHEF_VERSION"]
end
