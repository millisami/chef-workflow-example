#
# so this script actually only works for me, i'll probably fix that later or something.
#
# it just runs all of chef-workflow against every version of chef I intend to
# support. it's not a fast tool, or a nice tool, or a user-friendly tool. In
# fact, I'm only checking it in because i'm a flake and lose scripts easily.
#

do_error() {
  echo "Chef $CHEF_VERSION failed running $*"
  unset CHEF_VERSION
  unset LOCAL
  exit 1
}

verify_run() {
  if ! bundle exec rake $* --trace
  then
    do_error rake $*
  fi
}


for i in 10.18.2 10.18.0 10.16.6 10.16.4 10.16.2 10.16.0 10.14.4 10.14.2 10.14.0 10.12.0
do
  export CHEF_VERSION=$i 
  export LOCAL=1

  if ! bundle update
  then
    do_error bundle update
  fi

  verify_run chef_server:create
  verify_run chef:info:config
  verify_run chef:upload
  verify_run 'chef:build[syslog-server,1]'
  verify_run 'chef:converge[syslog-server]'
  verify_run chef:info:ips
  verify_run chef:info:provisioned
  verify_run chef:clean:machines
  verify_run test
  verify_run test:recipes
  verify_run chef:clean
done
