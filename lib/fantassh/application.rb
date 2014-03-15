require_relative 'bash_history'
require_relative 'entries'

module Fantassh
  class Application
    def initialize
      @entries = Entries.new
      @bash_history = BashHistory.new
    end

    def run
      @entries.add(@bash_history.entries)
      # indent by whitespace so it doesn't show up in the history
      exec " ssh $(cat #{@entries.entries_file} | selecta)"
    end
  end
end
