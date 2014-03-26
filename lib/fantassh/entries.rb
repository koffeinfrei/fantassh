require_relative 'entries_file'
require_relative 'excluded_entries_file'

module Fantassh
  class Entries
    def initialize(entries_file: EntriesFile.new, excluded_entries_file: ExcludedEntriesFile.new)
      @entries_file = entries_file
      @excluded_entries_file = excluded_entries_file

      init_file_structure
    end

    def add(entries)
      @entries_file.add(entries)
    end

    def all
      @entries_file.all - @excluded_entries_file.all
    end

    def exclude(entries)
      @excluded_entries_file.add(entries)
    end

    def init_file_structure
      @entries_file.init_file_structure
      @excluded_entries_file.init_file_structure
    end
  end
end
