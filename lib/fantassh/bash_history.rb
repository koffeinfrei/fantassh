module Fantassh
  class BashHistory
    def entries
      File.readlines(File.join(Dir.home, '.bash_history')).
        grep(/^\s*ssh\s/).
        map(&:strip).
        uniq.
        map { |x| x.gsub(/^ssh\s+/, '') }
    end
  end
end
