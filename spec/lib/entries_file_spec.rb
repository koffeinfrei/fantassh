require 'spec_helper'
require 'fantassh/entries_file'

module Fantassh
  describe EntriesFile do
    subject { EntriesFile.new(config_dir: '/dir') }

    context "#all" do
      it "returns all entries" do
        File.should_receive(:readlines).with('/dir/entries').
          and_return(["host1.com\n", "user@host2.com\n"])

        subject.all.should == ['host1.com', 'user@host2.com']
      end
    end

    context "#add" do
      before do
        file = double('file')
        File.should_receive(:open).with('/dir/entries', 'w').and_yield(file)
        file.should_receive(:puts).with(["host1.com"])
      end

      it "adds a new entry" do
        subject.stub(all: [])
        subject.stub(excluded: [])

        subject.add(["host1.com"])
      end

      it "doesn't add a duplicate" do
        subject.stub(all: ["host1.com"])
        subject.stub(excluded: [])

        subject.add(["host1.com"])
      end

      it "doesn't add an empty entry" do
        subject.stub(all: ["host1.com"])
        subject.stub(excluded: [])

        subject.add([''])
      end

      it "removes leading and trailing whitespace" do
        subject.stub(all: [])
        subject.stub(excluded: [])

        subject.add(["  host1.com\n\n"])
      end
    end
  end
end
