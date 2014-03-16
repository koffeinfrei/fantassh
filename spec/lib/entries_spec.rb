require 'spec_helper'
require 'fantassh/entries'

module Fantassh
  describe Entries do
    before { Entries.any_instance.stub(:init_file_structure) }
    subject { Entries.new(config_dir: '/dir') }

    context "#excluded" do
      it "returns the hidden entries" do
        File.should_receive(:readlines).and_return(["host1.com\n"])

        subject.excluded.should == ['host1.com']
      end
    end

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

      it "doesn't add a hidden entry" do
        subject.stub(all: ["host1.com"])
        subject.stub(excluded: ["user@host2.com"])

        subject.add(["user@host2.com"])
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
