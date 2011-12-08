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
      def initialize(name, description, category)
        @name        = name
        @description = description
        @category    = category
      end
    end
  end
end
