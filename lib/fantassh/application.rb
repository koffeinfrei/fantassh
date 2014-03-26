require 'slop'
require_relative 'bash_history'
require_relative 'entries'

module Fantassh
  class Application
    class << self
      def run(argv = ARGV)
        Slop.parse(argv, help: true) do
          on '-v', '--version', 'Print the program version.' do
            puts "#{File.basename($0)} v#{Fantassh::VERSION}"
            exit
          end

          # default, runs when called without arguments
          run do
            Fantassh::Application.list
          end

          command :exclude do
            banner "Usage: #{File.basename($0)} exclude <ssh command>"

            run do |opts, args|
              if args.empty?
                puts help
                exit
              end

              Fantassh::Application.exclude(args.join(' '))
            end
          end
        end
      end

      def list
        entries.add(bash_history.entries)

        selected_entry = `echo '#{entries.all.join("\n")}' | selecta`
        # in case selecta receives ctrl+c we don't proceed
        unless selected_entry.empty?
          # indent by whitespace so it doesn't show up in the history
          exec " ssh #{selected_entry}"
        end
      end

      def exclude(entry)
        entries.exclude([entry])
      end

      def entries
        Entries.new
      end

      def bash_history
        BashHistory.new
      end
    end
  end
end
