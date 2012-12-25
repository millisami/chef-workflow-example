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

gem 'moneta', '~> 0.6.0'
gem 'chef', '10.16.2'
