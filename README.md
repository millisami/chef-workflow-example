Example Chef-Workflow Repository
--------------------------------

Here's a repository you can clone and get going right now to see how the system
works. Nobody's shy about saying chef-workflow takes an initial effort to get
started, but at least this way you know what you're getting into first.

What you need
-------------

* VirtualBox
* SQLite libraries and headers to build the sqlite3 gem
* Ruby 1.9.3 and a recent version of Bundler

Problems you may have
---------------------

* Each machine uses around 384MB of ram apiece, and in total 5 machines spawn,
  although not all at once nor do they all run at the same time. You will
  almost always have the chef server running, 3 machines are used for an
  integration test and 1 machine is used for a recipe test. Use a machine that
  can handle this accordingly. Alternatively, you can use EC2, but you'll need
  to configure things to do so. See the documentation.

* If you have real machines in the 10.10.10.0/24 subnet you will run into
  problems accessing them while using this system. You can override this
  network specification in `lib/chef-workflow-config.rb` or with the
  environment variable `TEST_CHEF_SUBNET`. See the wiki or the configuration
  comments for more information.

Usage
-----

* Clone this repository, or fork it and clone your fork.
* Run `bundle` in the repository root.
* From here you should be able to do a full test run: `bundle exec rake
  test:full`, which builds a chef server, populates it, and runs some tests
  against machines that are created.
* Beyond that, you should consult the
  [documentation](https://github.com/chef-workflow/chef-workflow/wiki).
