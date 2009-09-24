$:.unshift File.join(File.dirname(__FILE__), 'lib', 'ruby')

require 'rake'
require 'rubygems'
require 'dotto'

BUILDDIR=Dotto::BUILD_DIR

Dir['tasks/**/*.rake', 'zsh/tasks/**/*.rake', 'apps/*/tasks/**/*.rake', 
    'lib/*/tasks/**/*.rake', 'external/*/tasks/**/*.rake', 
    'external/*/lib/*/tasks/**/*.rake'].each do |taskfile|
   import taskfile
end

task :default => :help do
end

desc "Show help"
task :help do
  system %Q{rake -T}
end

# desc "Clean compiled zwc files"
# task :clean do
#   puts "Doing clean..."
# end
# 
# desc "Clean all junk"
# task :realclean => [:clean, :clearlog] do
#   puts "Doing realclean..."
# end

