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
  end
end
