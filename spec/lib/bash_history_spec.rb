require 'spec_helper'
require 'fantassh/entries'

module Fantassh
  describe BashHistory do
    subject { BashHistory.new }

    context "#entries" do
      it "returns entries that start with 'ssh'" do
        File.stub(readlines: ["ssh host1.com\n", "host2.com\n", "\n"])

        subject.entries.should == ['host1.com']
      end

      it "ignores duplicates" do
        File.stub(readlines: ["ssh host1.com\n", "ssh host1.com\n"])

        subject.entries.should == ['host1.com']
      end

      it "removes leading and trailing whitespace" do
        File.stub(readlines: ["  ssh host1.com\n\n"])

        subject.entries.should == ['host1.com']
      end
    end
  end
end
