require_relative 'bash_history'
require_relative 'store'

module Fantassh
  class Application
    def initialize
      @store = Store.new
      @bash_history = BashHistory.new
    end

    def run
      @store.add_white_entries(@bash_history.entries)
      # indent by whitespace so it doesn't show up in the history
      exec " ssh $(cat #{@store.white_file_path} | selecta)"
    end
  end
end
