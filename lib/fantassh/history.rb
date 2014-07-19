require_relative 'history_file'

module Fantassh
  class History
    def initialize(file: HistoryFile.new)
      @file = file

      @file.init_file_structure
    end

    def last
      @file.all.last
    end

    def add(entry)
      @file.add([entry])
    end
  end
end
