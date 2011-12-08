require 'test_helper'

module Springpad
  describe CLI do
    describe "#edit" do
      it 'edits a file and returns the contents' do
        cli = CLI.new

        Tempfile.stubs(:new).returns file = stub_everything
        file.stubs(:path).returns "/tmp/something"
        file.stubs(:read).returns """Name of the task  \n\n This is a description of the task\nThis is more body for the task\n"
        cli.expects(:system).with("$EDITOR /tmp/something")

        cli.edit.must_equal [
          "Name of the task",
          [
            "This is a description of the task",
            "This is more body for the task",
          ]
        ]
      end
    end
  end
end
