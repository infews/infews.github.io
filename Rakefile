require 'securerandom'
require 'open3'
require "bundler/setup"
require "html-proofer"

desc "Generate a Middleman unique ID for what have you"
task :id do
  puts "uri:uuid:#{SecureRandom.uuid}"
end

desc "Generate a new article; usage rake [ARTICLE TITLE]"
task :article do
  sh "middleman article \"#{ARGV[1]}\""
  exit
end

desc "Generate the site for GitHub pages"
task :build => :clean do
  # generate the site
  sh "bundle exec middleman build clean"
  # rename the output for GitHub pages
  sh "mv build docs"
  # GitHub pages file means that they won't attempt to re-jekyll
  sh "echo 'Built with Middleman' > docs/.nojekyll"
end

desc "Clean all output directories"
task :clean => :ensure_clean_git do
  # delete the temp/dev directory and the GitHub pages output directory
  sh "rm -rf build"
  sh "rm -rf docs"
end

desc "Prevent cleaning & building with uncommitted changes"
task :ensure_clean_git do
  stdout, stderr, status = Open3.capture3("git status -s")

  if !stdout.empty?
    puts
    puts "\e[33m"
    puts ">>> Please commit all changes before re-building so resume has the correct version #"
    puts "\e[0m"
    exit 1
  end
end

desc "Validate all the HTML, including links"
task :html_proof do
  options = {
    ignore_empty_mailto: true
  }
  HTMLProofer.check_directory("./docs", options).run
end


namespace :unsplash do
  desc "Find an unsplash photo"
  task :find do
    require 'unsplash'
    Unsplash.configure do |config|
      config.application_access_key = "eifkvBuxX_TUwJYsuWyaQnXr0np7fNBnqFI5s5EaFdk"
      config.application_secret = "VGOWjQ5VDGc2iG-vUAowPu0hGVoCUxeASa1zq7dT3fw"
      config.utm_source = "dwfs_journal_big_pencil"
    end

    photo = Unsplash::Photo.find(ENV["ID"])
    puts photo[:urls][:regular]
  end
end