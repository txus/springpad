require 'rest-client'
require 'yaml'
require 'json'
require 'cgi'

module Springpad
  # Public: The best way to communicate with the Springpad API.
  #
  # Examples
  #
  #   api = Springpad::API.new
  #   api.notes
  #   # => [..., ..., ...] # Your notes on Springpad
  #
  class API
    # Public: Initializes a new API instance with credentials stored in a
    # configuration file.
    def initialize
      config = YAML.load(File.read(File.expand_path("~/.springpad")))
      @user     = config['user']
      @password = config['password']
      @token    = config['token']
      @url      = "http://springpadit.com/api"
    end

    # Public: Gets your notes with optional filters.
    #
    # filters - the Hash filters to apply to the search
    #
    # Returns an Array of Blocks::Note.
    def notes(filters={})
      get_blocks("Note", filters)
    end

    # Public: Gets your tasks with optional filters.
    #
    # filters - the Hash filters to apply to the search
    #
    # Returns an Array of Blocks::Task.
    def tasks(filters={})
      get_blocks("Task", filters)
    end

    # Public: Adds a new note to Springpad.
    #
    # contents - the Array contents of the note
    #
    # Returns the Boolean response.
    def add_note(contents, options={})
      note = Blocks::Note.new(contents.first, contents[1..-1].join("\n"))
      post_block(note)
    end

    # Public: Adds a new task to Springpad.
    #
    # contents - the Array contents of the task
    #
    # Returns the Boolean response.
    def add_task(contents, options={})
      task = Blocks::Task.new(contents.first, contents[1..-1].join("\n"))
      post_block(task)
    end

    # Public: Pushes a block to Springpad.
    #
    # contents - the Block to be pushed
    #
    # Returns the Boolean response.
    def post_block(block)
      shard = get_shard

      JSON.parse(
        RestClient.post(
          @url + "/users/me/commands",
          block.to_params(shard),
          headers.update({
            "Content-Type" => "application/json"
          })
        )
      )["success"]
    end

    ## Internal methods: to be extracted
    #
    # Internal: Authentication headers to perform API calls.
    #
    # Returns the Hash headers.
    def headers
      {
        "X-Spring-Username"  => @user,
        "X-Spring-Password"  => @password,
        "X-Spring-Api-Token" => @token,
      }
    end

    # Internal: Gets the user shard through an API call.
    #
    # Returns the String shard.
    def get_shard
      JSON.parse(RestClient.get(@url + "/users/me", headers))["shard"]
    end


    # Internal: Gets a collection of blocks of a given type applying some
    # filters.
    #
    # type    - the String type of block
    # filters - the hash filters to apply to the search
    #
    # Returns an Array of Blocks::Block.
    def get_blocks(type, filters)
      json = get("/users/#{@user}/blocks",
         :type    => type,
         :filters => filters)

      Blocks.const_get(type).process(json)
    end

    # Internal: Performs a GET request on a generated URL using the credentials
    # from the API instance.
    #
    # route   - the String URI of the API resource
    # options - a Hash of options
    #
    # Returns the Hash parsed JSON response.
    def get(route, options={})
      url  = generate(route, options)
      JSON.parse(
        RestClient.get(
          url,
          "X-Spring-Username"  => @user,
          "X-Spring-Password"  => @password,
          "X-Spring-Api-Token" => @token
        )
      )
    end

    # Internal: Generates a route and applies some options to it as query
    # parameters.
    #
    # route   - the String URI of the API resource
    # options - a Hash of options to narrow down the search
    #
    # Returns the String generated route.
    def generate(route, options)
      base = @url + route
      return base if options.empty?
      base += "?"
      opts = []

      opts << "type=#{options[:type]}" if options[:type]
      opts << "text=#{options[:matching]}" if options[:matching]
      opts += extract_filters(options[:filters])

      base += opts.join("&")
      base
    end

    # Internal: Extracts filters from a Hash to be encoded as a special form of
    # query parameter.
    #
    # f - the Hash of filters to apply
    #
    # Returns the single-element Array with the query parameter.
    def extract_filters(f)
      filts = []

      filts << "type=#{f[:type]}" if f[:type]
      filts << "userAction=#{f[:userAction]}" if f[:userAction]
      filts << "public=#{f[:public]}" if f[:public]
      filts << "complete=#{f[:complete]}" if f[:complete]
      filts << "isInPast=#{f[:isInPast]}" if f[:isInPast]
      filts << "flagged=#{f[:flagged]}" if f[:flagged]

      if filts.any?
        ["filter=#{CGI.escape(filts.join(" and "))}"]
      else
        []
      end
    end
  end
end
