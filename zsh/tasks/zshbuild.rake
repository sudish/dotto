require 'fileutils'
require 'dotto/zsh'

ZSH_VERSION=Dotto::Zsh.system("echo $ZSH_VERSION")
ZCONFIGDIR = "#{Dotto::DIR}/zsh"
ZSHBUILDDIR = "#{BUILDDIR}/zsh/#{ZSH_VERSION}"
ZSH=Dotto::Zsh.path

namespace :zsh do 
  def zsh(commandline)
    Dotto::Zsh.system commandline
  end

  desc "Show ZSH versions and variables"
  task :info do
    puts "Z-Shell located at #{ZSH}, version #{ZSH_VERSION}"
    puts "Build directory is #{ZSHBUILDDIR}"
  end

  desc "Clean compiled zwc files"
  task :clean do
    puts "Cleaning zsh..."
    system %Q{find . -name \*.zwc | xargs rm -f}
    system %Q{rm -rf "./local/build/*"}
  end

  file ZSHBUILDDIR => BUILDDIR do |t|
    FileUtils.mkdir_p ZSHBUILDDIR
  end

  desc "Compile all files"
  task :compile => [ZSHBUILDDIR,"#{ZSHBUILDDIR}/functions.zwc", "#{ZSHBUILDDIR}/libfunctions.zwc"]  do
    puts "ZSH compile done"
  end

  file "#{ZSHBUILDDIR}/functions.zwc" => Dir.glob("#{ZCONFIGDIR}/functions/*") do |t|
    zsh "zcompile #{t} #{t.prerequisites.join(" ")}"
  end

  ZSHFUNCDIRS = ["#{ZCONFIGDIR}/lib/*/functions/*", "#{Dotto::DIR}/external/*/zsh/functions/*"]

  file "#{ZSHBUILDDIR}/libfunctions.zwc" => Dir.glob(ZSHFUNCDIRS) do |t|
    zsh "zcompile -U #{t} #{t.prerequisites.join(" ")}"
  end
end

task :compile => :"zsh:compile"
task :clean => :"zsh:clean"
