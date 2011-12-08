module Springpad
  module Blocks
    def self.types
      [
        "note",
        "task",
      ]
    end
  end
end

Springpad::Blocks.types.each do |type|
  require_relative "blocks/#{type}"
end
