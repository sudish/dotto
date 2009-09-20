require 'fileutils'

ZSH=ENV['SHELL'] || '/bin/zsh'

def zsh(commandline)
  %x[#{ZSH} -c '#{commandline}'].chomp
end

ZSH_VERSION=zsh("echo $ZSH_VERSION")

DOTTODIR = Dir.pwd
ZCONFIGDIR = "#{DOTTODIR}/zsh"

BUILDDIR = "local/build"
ZSHBUILDDIR = "#{BUILDDIR}/zsh/#{ZSH_VERSION}"

task :default => :help do
end

desc "Show ZSH versions and variables"
task :info do
  puts "ZSH_VERSION is #{ZSH_VERSION}, #{ZSH}"
  puts "BUILDDIR is #{BUILDDIR}"
end

desc "Show help"
task :help do
  system %Q{rake -T}
end

desc "Pull and update from repository"
task :update => [:pull, :updatelocal]

desc "Pull latest from repository"
task :pull do
  system %Q{git pull}
  Dir.glob("external/*/.git").each do |gitdir|
    dir=File.dirname gitdir
    puts "Pulling external dir #{dir} with Git"
    system %Q{cd #{dir} && git pull}
  end
  Dir.glob("external/*/.svn").each do |gitdir|
    dir=File.dirname gitdir
    puts "Pulling external dir #{dir} with Subversion"
    system %Q{cd #{dir} && svn update}
  end
  Dir.glob("external/*/.hg").each do |gitdir|
    dir=File.dirname gitdir
    puts "Pulling external dir #{dir} with Mercurial"
    system %Q{cd #{dir} && hg pull}
  end
end

desc "Push external dir changes into upstream repository"
task :pull do
  Dir.glob("external/*/.git").each do |gitdir|
    dir=File.dirname gitdir
    puts "Pulling external dir #{dir}"
    system %Q{cd #{dir} && git push}
  end
end

desc "Install in home directory"
task :install do
  system %Q{yes n | ./setup/install.zsh}
end

desc "Update installation from local files"
task :updatelocal => [:clean, :install, :compile]

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

file ZSHBUILDDIR do |t|
  FileUtils.mkdir_p ZSHBUILDDIR
end


desc "Compile all files"
task :compile => [BUILDDIR,ZSHBUILDDIR,"#{ZSHBUILDDIR}/functions.zwc", "#{ZSHBUILDDIR}/libfunctions.zwc"]  do
  puts "Compile done"
end

file "#{ZSHBUILDDIR}/functions.zwc" => Dir.glob("#{ZCONFIGDIR}/functions/*") do |t|
  zsh "zcompile #{t} #{t.prerequisites.join(" ")}"
end

FUNCDIRS = ["#{ZCONFIGDIR}/lib/*/functions/*", "#{DOTTODIR}/external/*/zsh/functions/*"]

file "#{ZSHBUILDDIR}/libfunctions.zwc" => Dir.glob(FUNCDIRS) do |t|
  zsh "zcompile -U #{t} #{t.prerequisites.join(" ")}"
end
