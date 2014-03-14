require 'fileutils'

module Fantassh
  class Store
    attr_reader :white_file_path

    def initialize
      @dir_path = File.join(Dir.home, '.fantassh')
      @white_file_path = File.join(@dir_path, 'white_entries')
      @black_file_path = File.join(@dir_path, 'black_entries')
      init_file_structure
    end

    def entries
      white_entries - black_entries
    end

    def white_entries
      File.readlines(@white_file_path).map(&:strip)
    end

    def black_entries
      File.readlines(@black_file_path).map(&:strip)
    end

    def add_white_entries(new_entries)
      entries = ((white_entries + new_entries).map(&:strip).uniq -
                 black_entries).delete_if { |x| x.empty? }

      File.open(@white_file_path, 'w') do |f|
        f.puts(entries)
      end
    end

    def init_file_structure
      unless Dir.exist?(@dir_path)
        FileUtils.mkdir(@dir_path)
      end
      FileUtils.touch(@white_file_path)
      FileUtils.touch(@black_file_path)
    end
  end
end
