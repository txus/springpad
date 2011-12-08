require 'highline'
require 'stringio'
require 'securerandom'

module Springpad
  module Blocks
    # Public: Maps to a Springpad Note block.
    #
    # Examples
    #
    #   Blocks::Note.process(json_notes)
    #   # => [#<Blocks::Note>..., #<Blocks::Note...>,]
    #
    class Note
      attr_reader :name, :text
      # Public: Converts a Hash of JSON note blocks to an Array of actual Note
      # instances.
      #
      # json - the Hash JSON with the note blocks
      #
      # Returns an Array of Notes.
      def self.process(json)
        json.map do |note|
          Note.new(
            note['name'] || "(no title)",
            note['properties']['text']
          )
        end
      end

      # Internal: Initializes a new Note.
      #
      # name - the String name
      # text - the String text content
      def initialize(name, text)
        @name = name
        @text = text
      end

      # Public: Renders a note to the standard output.
      #
      # Returns nothing.
      def render
        out = HighLine.new
        out.wrap_at = 78
        out.say <<-RENDER
<%=color("#{@name}", :bold)%>
<%='-'*#{@name.length}%>
#{@text}
RENDER
      end

      # Public: Creates a query to create a Note in Springpad.
      #
      # shard - the String user shard.
      #
      # Returns the String JSON commands.
      def to_params(shard)
        uuid = "/UUID(#{shard}3#{SecureRandom.uuid[3..-1]})/"
        [
          ["create", "Note", uuid],
          ["set", uuid, "name", @name],
          ["set", uuid, "text", @text]
        ].to_json
      end
    end
  end
end
