module Springpad
  module Blocks
    # Public: Maps to a Springpad Task block.
    #
    # Examples
    #
    #   Blocks::Task.process(json_tasks)
    #   # => [#<Blocks::Task>..., #<Blocks::Task...>,]
    #
    class Task
      attr_reader :name, :description, :category
      # Public: Converts a Hash of JSON task blocks to an Array of actual Task
      # instances.
      #
      # json - the Hash JSON with the task blocks
      #
      # Returns an Array of Tasks.
      def self.process(json)
        json.map do |task|
          Task.new(
            task['name'],
            task['properties']['description'],
            task['properties']['category']['name']
          )
        end
      end

      # Internal: Initializes a new Task.
      #
      # name        - the String name
      # description - the String description
      # category    - the String category
      def initialize(name, description, category="")
        @name        = name
        @description = description
        @category    = category
      end

      # Public: Renders a task to the standard output.
      #
      # Returns nothing.
      def render
        out = HighLine.new
        out.wrap_at = 78
        out.say <<-RENDER
<%=color("#{@name}", :bold)%> [#{@category.upcase}]
<%='-'*#{@name.length}%>
#{@description}
RENDER
      end

      # Public: Creates a query to create a Task in Springpad.
      #
      # shard - the String user shard.
      #
      # Returns the String JSON commands.
      def to_params(shard)
        uuid = "/UUID(#{shard}3#{SecureRandom.uuid[3..-1]})/"
        [
          ["create", "Note", uuid],
          ["set", uuid, "name", @name],
          ["set", uuid, "description", @description],
          ["set", uuid, "category", @category]
        ].to_json
      end
    end
  end
end
