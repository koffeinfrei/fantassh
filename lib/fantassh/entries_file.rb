require 'fileutils'

module Fantassh
  class EntriesFile
    def initialize(config_dir: nil)
      @config_dir = config_dir || File.join(Dir.home, '.fantassh')
    end

    def all
      File.readlines(file).map(&:strip)
    end

    def add(new_entries, reject_duplicates: true)
      new_entries = new_entries.map(&:strip).reject(&:empty?)
      entries = all + new_entries

      if reject_duplicates
        entries.uniq!
      end

      File.open(file, 'w') do |f|
        f.puts(entries)
      end
    end

    def file
      File.join(@config_dir, 'entries')
    end

    def init_file_structure
      unless Dir.exist?(@config_dir)
        FileUtils.mkdir(@config_dir)
      end
      FileUtils.touch(file)
    end
  end
end
