require 'spec_helper'
require 'fantassh/history_file'

module Fantassh
  describe HistoryFile do
    subject { HistoryFile.new(config_dir: '/dir') }

    context "#add" do
      let(:file) do
        file = double('file')
        File.should_receive(:open).with('/dir/history', 'w').and_yield(file)
        file
      end

      it "adds a duplicate" do
        file.should_receive(:puts).with(["host1.com", "host1.com"])
        subject.stub(all: ["host1.com"])

        subject.add(["host1.com"])
      end
    end
  end
end
