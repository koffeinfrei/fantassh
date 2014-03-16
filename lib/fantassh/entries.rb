require 'fileutils'

module Fantassh
  class Entries
    attr_reader :entries_file

    def initialize(config_dir: nil)
      @config_dir = config_dir || File.join(Dir.home, '.fantassh')
      @entries_file = File.join(@config_dir, 'entries')
      @excluded_entries_file = File.join(@config_dir, 'excluded_entries')
      init_file_structure
    end

    def all
      File.readlines(@entries_file).map(&:strip)
    end

    def excluded
      File.readlines(@excluded_entries_file).map(&:strip)
    end

    def add(new_entries)
      new_entries = new_entries.map(&:strip).delete_if { |x| x.empty? }
      entries = (all + new_entries).uniq - excluded

      File.open(@entries_file, 'w') do |f|
        f.puts(entries)
      end
    end

    def init_file_structure
      unless Dir.exist?(@config_dir)
        FileUtils.mkdir(@config_dir)
      end
      FileUtils.touch(@entries_file)
      FileUtils.touch(@excluded_entries_file)
    end
  end
end
