# encoding: utf-8
require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['./test/**/*_test.rb']
end

desc "Checks the user has appropriate credentials"
task :check_credentials do
  begin
    config = YAML.load(File.read(File.expand_path("~/.springpad")))
  rescue
    raise StandardError, "File ~/.springpad does not exist. You must create it in a YAML format with 'user', 'password' and 'token' fields."
  end
  unless config['user'] && config['password'] && config['token']
    raise StandardError, "One of the three fields (either user, password or token) is not filled properly in ~/.springpad. Please check it."
  end
end

task :default => [:check_credentials, :test]
