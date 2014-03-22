require 'slop'
require_relative 'bash_history'
require_relative 'entries'

module Fantassh
  class Application
    class << self
      def run
        Slop.parse(ARGV, help: true) do
          on '-v', '--version', 'Print the program version.' do
            puts "#{File.basename($0)} v#{Fantassh::VERSION}"
          end

          run do
            Fantassh::Application.list
          end
        end
      end

      def list
        entries = Entries.new
        bash_history = BashHistory.new
        entries.add(bash_history.entries)
        # indent by whitespace so it doesn't show up in the history
        exec " ssh $(cat #{entries.entries_file} | selecta)"
      end
    end
  end
end
