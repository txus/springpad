require 'yaml'

module Springpad
  class API
    attr_reader :user, :password, :token
    def initialize
      config = YAML.load(File.read(File.expand_path("~/.springpad")))
      @user     = config['user']
      @password = config['password']
      @token    = config['token']
    end
  end
end
