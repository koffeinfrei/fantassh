require 'fileutils'
require_relative 'entries_file'

module Fantassh
  class HistoryFile < EntriesFile
    def file
      File.join(@config_dir, 'history')
    end

    # as opposed to the actual entries files we want to
    # have duplicates here to properly represent the
    # user's history
    def add(new_entries)
      super(new_entries, reject_duplicates: false)
    end
  end
end

