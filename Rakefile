require 'bundler/setup'
require 'rake'
require 'rspec/core/rake_task'

targets = %w(ruby19 ruby21 ruby22)

namespace :build do

#  task :all     => targets
#  task :default => :all

  targets.each do |target|
    desc "Build docker image #{target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      sh("TMPDIR=/Users/jacoelho/tmp ~/Downloads/packer-osx-patched-0.7.5/packer validate -var PACKER_IMAGE=#{target} teste.json")
      sh("TMPDIR=/Users/jacoelho/tmp ~/Downloads/packer-osx-patched-0.7.5/packer build -var PACKER_IMAGE=#{target} teste.json")
    end
  end
end

namespace :spec do
#  targets = []
#  Dir.glob('./spec/*').each do |dir|
#    next unless File.directory?(dir)
#    targets << File.basename(dir)
#  end

#  task :all     => targets
#  task :default => :all

  targets.each do |target|
    desc "Run serverspec tests to #{target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['DOCKER_IMAGE'] = "minimum2scp/#{target}:latest"
      t.pattern = "spec/#{target}/*_spec.rb"
    end
  end
end
