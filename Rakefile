require 'securerandom'

task :id do
  puts "uri:uuid:#{SecureRandom.uuid}"
end

task :build do
  sh "rm -rf build"
  sh "bundle exec middleman build clean"
  sh "mv build docs"
end
