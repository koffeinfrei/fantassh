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

    context 'last' do
      it 'runs the last called connection' do
        Dir.mktmpdir do |dir|
          history = History.new(
            file: HistoryFile.new(config_dir: dir))
          history.add('user@last')
          Application.stub(history: history)

          Application.should_receive(:exec).with(' ssh user@last')

          Application.run(['last'])
        end
      end

      it 'prints a message if the history is empty' do
        Dir.mktmpdir do |dir|
          history = History.new(
            file: HistoryFile.new(config_dir: dir))
          Application.stub(history: history)

          STDOUT.should_receive(:puts).with('There is no history entry just yet!')

          Application.run(['last'])
        end
      end
    end
  end
end
