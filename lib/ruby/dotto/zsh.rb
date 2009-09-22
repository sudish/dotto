
module Dotto
  class Zsh

    class << self
      def version
        system("echo $ZSH_VERSION")
      end

      def path
        @path ||= find_zsh
      end

      def find_zsh
        return ENV['SHELL'] if ENV['SHELL'] && ENV['SHELL'].match('zsh')
        name=ENV['ZSH_NAME'] || "zsh"
        ENV['PATH'].split(':').each do |dir|
          if File.executable?(file = File.join(dir, name))
            return file
          end
        end
      end

      def system(commandline)
        %x[#{path} -c '#{commandline}'].chomp
      end
    end
    
    # ZSHBUILDDIR = "#{BUILDDIR}/zsh/#{ZSH_VERSION}"

  end
end