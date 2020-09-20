require 'securerandom'

task :id do
  puts "uri:uuid:#{SecureRandom.uuid}"
end

task :build do
  sh "rm -rf build"
  sh "rm -rf docs"
  sh "mkdir -p docs"
  sh "bundle exec middleman build clean"
  #sh "mv -r build/* docs/*"
  #sh "echo 'Built with Middleman' > docs/.nojekyll"
end
