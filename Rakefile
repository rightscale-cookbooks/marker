require 'rspec/core/rake_task'
require 'foodcritic'
require 'kitchen'

# cookbook = File.foreach('metadata.rb').grep(/^name/).first.strip.split(' ').last.delete("'")
directory = File.expand_path(File.dirname(__FILE__))

desc 'Sets up knife, and vendors cookbooks'
task :setup_test_environment do
  File.open('knife.rb', 'w+') do |file|
    file.write <<-EOF
      log_level                :debug
      log_location             STDOUT
      cookbook_path            ['.', 'berks-cookbooks/']
    EOF
  end
  sh('berks vendor')
end

desc 'runs cookstyle'
task cookstyle: [:setup_test_environment] do
  cmd = 'bundle exec cookstyle -D --format offenses --display-cop-names'
  puts cmd
  sh(cmd)
end

desc 'runs foodcritic'
task :foodcritic do
  cmd = "bundle exec foodcritic --epic-fail any -t ~FC015 #{directory}"
  puts cmd
  sh(cmd)
end

desc 'runs foodcritic linttask'
task :fc_new do
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any']
    }
  end
end

desc 'runs rspec'
task :rspec do
  cmd = 'bundle exec rspec --color --format documentation'
  puts cmd
  sh(cmd)
end

desc 'runs testkitchen'
task :kitchen do
  cmd = 'chef exec kitchen test --concurrency=2'
  puts cmd
  sh(cmd)
end

desc 'runs all tests except kitchen'
task except_kitchen: [:cookstyle, :foodcritic, :rspec] do
  puts 'running all tests except kitchen'
end

desc 'runs all tests'
task all: [:except_kitchen, :kitchen] do
  puts 'running all tests'
end
