require 'test_helper'

module Springpad
  describe API do
    let(:config) { YAML.load(File.read(File.expand_path("~/.springpad"))) }
    let(:api) { API.new }

    it 'initializes a user and password from ~/.springpad' do
      api.instance_variable_get(:@user).must_equal config['user']
      api.instance_variable_get(:@password).must_equal config['password']
      api.instance_variable_get(:@token).must_equal config['token']
    end

    it "fetches the notes of the user" do
      notes = api.notes(:public => false)
      notes.length.must_be :>, 0
      notes.first.must_be_kind_of Blocks::Note
    end

    it "fetches the tasks of the user" do
      tasks = api.tasks(:public => false)
      tasks.length.must_be :>, 0
      tasks.first.must_be_kind_of Blocks::Task
    end

    it "posts a note" do
      contents = [
        "Note title",
        ["Note body", "yeah"]
      ]

      api.expects(:post_block).with do |note|
        note.name.must_equal "Note title"
        note.text.must_equal "Note body\nyeah"
      end.returns true

      api.add_note(contents).must_equal true
    end

    it "posts a task" do
      contents = [
        "Task title",
        ["Task description", "yeah"]
      ]

      api.expects(:post_block).with do |task|
        task.name.must_equal "Task title"
        task.description.must_equal "Task description\nyeah"
      end.returns true

      api.add_task(contents).must_equal true
    end

    it 'posts a block' do
      note = Blocks::Note.new("Note title", "Note body")
      api.post_block(note).must_equal true
    end
  end
end
