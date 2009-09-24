$:.unshift File.join(File.dirname(__FILE__), 'lib', 'ruby')

require 'rake'
require 'rubygems'
require 'dotto'

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
task :push do
  Dir.glob("external/*/.git").each do |gitdir|
    dir=File.dirname gitdir
    puts "Pushing external dir #{dir} upstream with Git"
    system %Q{cd #{dir} && git push}
  end
  Dir.glob("external/*/.hg").each do |gitdir|
    dir=File.dirname gitdir
    puts "Pushing external dir #{dir} upstream with Mercurial"
    system %Q{cd #{dir} && hg push}
  end
end

desc "Install in home directory"
task :install do
  system %Q{yes n | ./setup/install.zsh}
end

desc "Update installation from local files"
task :updatelocal => [:clean, :install, :compile]

# desc "Clean compiled zwc files"
# task :clean do
#   puts "Doing clean..."
# end
# 
# desc "Clean all junk"
# task :realclean => [:clean, :clearlog] do
#   puts "Doing realclean..."
# end

directory Dotto.build_dir

desc "Compile all files"
task :compile do
  puts "Compile done"
end
