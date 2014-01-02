#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'HydraEditor'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


Bundler::GemHelper.install_tasks

dummy = File.expand_path('../spec/dummy', __FILE__)
rakefile = File.join(dummy, 'Rakefile')

desc "Remove the dummy app"
task :clean do
  sh "rm -rf #{dummy}"
end

desc "Generate the dummy app"
task :setup do
  unless File.exists?("#{dummy}/Rakefile")
    `rails new #{dummy}`
    `cp -r spec/support/lib/generators #{dummy}/lib`
    Dir.chdir(dummy) do
      puts "Generating test app ..."
      sh "rails generate test_app"
	    sh "touch public/test.html"      # for spec/features/record_editing_spec.rb
    end
  end
end

desc "Run the spec tests"
task :spec => :setup do
  here = File.expand_path("../", __FILE__)
  Dir.chdir(dummy) do
    Bundler.with_clean_env do
      sh "bundle exec rspec --color -I#{here}/spec #{here}/spec"
    end
  end
end

task :default => :spec
