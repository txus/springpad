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
  end
end
