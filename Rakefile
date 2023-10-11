require "securerandom"
require "open3"
require "bundler/setup"
require "html-proofer"
require "standard/rake"
require "rspec/core/rake_task"

task default: [:"standard:fix", :spec]

desc "Generate a Middleman unique ID for what have you"
task :id do
  puts "uri:uuid:#{SecureRandom.uuid}"
end

desc "Generate a new article; usage rake [ARTICLE TITLE]"
task :article do
  sh "middleman article \"#{ARGV[1]}\""
  exit
end

desc "Validate all the HTML, including links"
task html_proof: :build do
  options = {
    ignore_empty_mailto: true,
    ignore_status_codes: [302, 307, 403, 429, 503, 999]
  }
  HTMLProofer.check_directory("./build", options).run
end

desc "Generate a clean site ready to publish"
task prep: :build do
  # rename the output for GitHub pages
  sh "mv build docs"
  # GitHub pages file means that they won't attempt to re-jekyll
  sh "echo 'Built with Middleman' > docs/.nojekyll"
  puts "Ready to commit and push."
end

desc "Generate the site"
task build: :clean do
  # generate the site
  sh "bundle exec middleman build clean"
end

desc "Clean all output directories"
task clean: :ensure_clean_git do
  # delete the temp/dev directory and the GitHub pages output directory
  sh "rm -rf build"
  sh "rm -rf docs"
end

desc "Prevent cleaning & building with uncommitted changes"
task :ensure_clean_git do
  stdout, _stderr, _status = Open3.capture3("git status -s")

  if !stdout.empty?
    puts
    puts "\e[33m"
    puts ">>> Please commit all changes before re-building so resume has the correct version #"
    puts "\e[0m"
    exit 1
  end
end

namespace :unsplash do
  desc "Find an unsplash photo"
  task :find do
    require "unsplash"
    Unsplash.configure do |config|
      config.application_access_key = "eifkvBuxX_TUwJYsuWyaQnXr0np7fNBnqFI5s5EaFdk"
      config.application_secret = "VGOWjQ5VDGc2iG-vUAowPu0hGVoCUxeASa1zq7dT3fw"
      config.utm_source = "dwfs_journal_big_pencil"
    end


    photo = Unsplash::Photo.find(ENV["ID"])
    puts photo[:urls][:regular]
  end
end
