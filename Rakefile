require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'echoe'

task :default => 'test'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

Echoe.new('qype', '0.1.0') do |p|
  p.description    = 'The official Ruby Library for interacting with the Qype API.'
  p.url            = 'http://github.com/qype/qype'
  p.author         = 'Florian Munz'
  p.email          = 'florian@qype.com'
end
