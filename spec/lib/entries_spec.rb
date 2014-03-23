require 'spec_helper'
require 'fantassh/entries'

module Fantassh
  describe Entries do
    let(:entries_file) { double(:entries_file) }

    let(:excluded_entries_file) { double(:excluded_entries_file) }

    context "#initialize" do
      it "calls init_file_structure on both entry files" do
        entries_file.should_receive(:init_file_structure)
        excluded_entries_file.should_receive(:init_file_structure)

        Entries.new(entries_file: entries_file, excluded_entries_file: excluded_entries_file)
      end
    end

    context "#all" do
      before { Entries.any_instance.stub(:init_file_structure) }

      it "returns an entry" do
        entries_file.should_receive(:all).and_return(["host1.com"])

        Entries.new(entries_file: entries_file).all.should ==
          ["host1.com"]
      end

      it "doesn't return a hidden entry" do
        entries_file.should_receive(:all).and_return(["host1.com"])
        excluded_entries_file.should_receive(:all).and_return(["user@host2.com"])

        Entries.new(entries_file: entries_file, excluded_entries_file: excluded_entries_file).
          all.should == ["host1.com"]
      end
    end
  end
end
