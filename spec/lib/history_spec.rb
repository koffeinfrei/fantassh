require 'spec_helper'
require 'fantassh/history'

module Fantassh
  describe History do
    let(:file) { double(:file, init_file_structure: nil) }

    context "#initialize" do
      it "calls init_file_structure on the file" do
        file.should_receive(:init_file_structure)

        History.new(file: file)
      end
    end

    context "#add" do
      it "calls #add on the file" do
        file.should_receive(:add).with(['user@last'])
        History.new(file: file).add('user@last')
      end
    end

    context "#last" do
      it "returns the last entry if there is one" do
        file.stub(all: ['user@last'])
        History.new(file: file).last.should == 'user@last'
      end

      it "returns nil if there is no entry" do
        file.stub(all: [])
        History.new(file: file).last.should be_nil
      end
    end
  end
end
