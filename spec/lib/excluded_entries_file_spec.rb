require 'spec_helper'
require 'fantassh/excluded_entries_file'

module Fantassh
  describe ExcludedEntriesFile do
    subject { ExcludedEntriesFile.new(config_dir: '/dir') }

    context "#all" do
      it "returns all entries" do
        File.should_receive(:readlines).with('/dir/excluded_entries').
          and_return(["user@host2.com\n"])

        subject.all.should == ['user@host2.com']
      end
    end
  end
end
