require "rubygems"
require "bundler/setup"

require "serverspec"
require "docker"

set :backend, :docker
set :docker_url, ENV["DOCKER_HOST"]

# TODO https://github.com/swipely/docker-api/issues/202
Excon.defaults[:ssl_verify_peer] = false
