require 'fileutils'
require_relative 'entries_file'

module Fantassh
  class ExcludedEntriesFile < EntriesFile
    def file
      File.join(@config_dir, 'excluded_entries')
    end
  end
end
