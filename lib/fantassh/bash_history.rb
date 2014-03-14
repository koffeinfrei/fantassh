module Fantassh
  class BashHistory
    def entries
      File.readlines(File.join(Dir.home, '.bash_history')).
        grep(/^ssh/).
        uniq.
        map { |x| x.gsub(/^ssh/, '') }.
        map(&:strip)
    end
  end
end
