require 'fileutils'


module Dotto
  DIR = Dir.pwd
  BUILD_DIR = "#{DIR}/local/build"

  def self.dir; DIR; end
  def self.build_dir; BUILD_DIR; end
end

require 'dotto/zsh'


