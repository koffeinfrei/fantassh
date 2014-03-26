require 'spec_helper'
require 'tmpdir'

module Fantassh
  describe Application do
    context 'exclude' do
      it 'adds an entry to the excluded entries' do
        Dir.mktmpdir do |dir|
          entries_file = Entries.new(
            entries_file: EntriesFile.new(config_dir: dir),
            excluded_entries_file: ExcludedEntriesFile.new(config_dir: dir))
          Application.stub(entries: entries_file)

          Application.run(['exclude', 'ssh bogus'])

          File.readlines(File.join(dir, 'excluded_entries')).should == ["ssh bogus\n"]
        end
      end
    end
  end
end
