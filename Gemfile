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


gem 'chef', (ENV["CHEF_VERSION"] || '10.18.2')

if ENV["CHEF_VERSION"]
  if ENV["CHEF_VERSION"] < "10.16.4"
    gem 'moneta', '~> 0.6.0'
  end
  gem 'chef', ENV["CHEF_VERSION"]
else
  gem 'chef'
end
