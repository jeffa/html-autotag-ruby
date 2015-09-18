require "bundler/gem_tasks"

task :default => [:test]

task :test do
    Dir.glob( './t/*.rb' ).each { |file| require file }
end
