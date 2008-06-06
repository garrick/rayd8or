# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'rcov/rcovtask'

namespace :test do 
  namespace :coverage do
    desc "Delete aggregate coverage data."
    task(:clean) { rm_f "coverage.data" }
  end
  desc 'Aggregate code coverage for unit, functional and integration tests'
  task :coverage => "test:coverage:clean"
  %w[shared].each do |target|
    namespace :coverage do
      Rcov::RcovTask.new(target) do |t|
        t.libs << "test"
        #t.test_files = FileList["test/#{target}/test_*.rb"]
        t.test_files = FileList["test/server/test_*.rb"] + FileList["test/shared/test_*.rb"]

#        t.output_dir = "test/coverage/#{target}"
        t.output_dir = "test/coverage/all"
        t.verbose = true
        t.rcov_opts << '--aggregate coverage.data'
      end
    end
    task :coverage => "test:coverage:#{target}"
  end
end

Hoe.new('rayd8or', '1.0.0') do |p|
   p.rubyforge_name = 'rayd8orx' # if different than lowercase project name
   p.developer('Garrick West', 'garrick@acm.org')
end

# vim: syntax=Ruby
