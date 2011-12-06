require 'yaml'

module Springpad
  class API
    # Public: Initializes a new API instance with credentials stored in a
    # configuration file.
    def initialize
      config = YAML.load(File.read(File.expand_path("~/.springpad")))
      @user     = config['user']
      @password = config['password']
      @token    = config['token']
    end
  end
end
