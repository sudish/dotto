require 'fileutils'
require 'dotto/zsh'

def zsh_version; Dotto::Zsh.system("echo $zsh_version"); end
def zconfigdir; "#{Dotto::DIR}/zsh"; end
def zsh_build_dir; "#{BUILDDIR}/zsh/#{zsh_version}"; end
def zsh_path; Dotto::Zsh.path; end

namespace :zsh do 
  def zsh(commandline)
    Dotto::Zsh.system commandline
  end

  desc "Show zsh_path versions and variables"
  task :info do
    puts "Z-Shell located at #{zsh_path}, version #{zsh_version}"
    puts "Build directory is #{zsh_build_dir}"
  end

  desc "Clean compiled zwc files"
  task :clean do
    puts "Cleaning zsh..."
    system %Q{find . -name \*.zwc | xargs rm -f}
    system %Q{rm -rf "./local/build/*"}
  end

  directory zsh_build_dir

  desc "Compile all files"
  task :compile => [zsh_build_dir,"#{zsh_build_dir}/functions.zwc", "#{zsh_build_dir}/libfunctions.zwc"]  do
    puts "zsh_path compile done"
  end

  file "#{zsh_build_dir}/functions.zwc" => Dir.glob("#{zconfigdir}/functions/*") do |t|
    zsh "zcompile #{t} #{t.prerequisites.join(" ")}"
  end

  ZSHFUNCDIRS = ["#{zconfigdir}/lib/*/functions/*", "#{Dotto::DIR}/external/*/zsh/functions/*"]

  file "#{zsh_build_dir}/libfunctions.zwc" => Dir.glob(ZSHFUNCDIRS) do |t|
    zsh "zcompile -U #{t} #{t.prerequisites.join(" ")}"
  end
end

task :compile => :"zsh:compile"
task :clean => :"zsh:clean"
