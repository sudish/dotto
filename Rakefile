require 'fileutils'

ZSH=ENV['SHELL'] || '/bin/zsh'

def zsh(commandline)
  %x[#{ZSH} -c '#{commandline}'].chomp
end

ZSH_VERSION=zsh("echo $ZSH_VERSION")

ZCONFIGDIR = Dir.pwd
BUILDDIR = "local/build/#{ZSH_VERSION}"

task :default => :help do
end

task :info do
  puts "ZSH_VERSION is #{ZSH_VERSION}"
  puts "BUILDDIR is #{BUILDDIR}"
end

task :help do
  system %Q{rake -T}
end

desc "Clean compiled zwc files"
task :clean do
  puts "Cleaning..."
  system %Q{find . -name \*.zwc | xargs rm -f}
  system %Q{rm -rf "./local/build/*"}
end

desc "Clean all junk"
task :realclean => [:clean, :clearlog] do
  puts "Doing realclean..."
end

file BUILDDIR do |t|
  FileUtils.mkdir_p BUILDDIR
end

desc "Compile all files"
task :compile => [BUILDDIR,"#{BUILDDIR}/functions.zwc", "#{BUILDDIR}/libfunctions.zwc"]  do
  puts "Compile done"
end

file "#{BUILDDIR}/functions.zwc" => Dir.glob("functions/*") do |t|
  zsh "zcompile #{t} #{t.prerequisites.join(" ")}"
end

file "#{BUILDDIR}/libfunctions.zwc" => Dir.glob("lib/*/functions/*") do |t|
  zsh "zcompile #{t} #{t.prerequisites.join(" ")}"
end
