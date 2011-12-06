require 'test_helper'

module Springpad
  describe API do
    it 'initializes a user and password from ~/.springpad' do
      config = YAML.load(File.read(File.expand_path("~/.springpad")))

      api = API.new
      api.user.must_equal config['user']
      api.password.must_equal config['password']
      api.token.must_equal config['token']
    end
  end
end
