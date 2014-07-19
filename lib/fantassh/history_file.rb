require 'fileutils'
require_relative 'entries_file'

module Fantassh
  class HistoryFile < EntriesFile
    def file
      File.join(@config_dir, 'history')
    end
  end
end

