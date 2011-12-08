require_relative "springpad/version"
require_relative "springpad/api"
require_relative "springpad/blocks"
require_relative "springpad/cli"

module Springpad
  def self.list(type, options)
    api = Springpad::API.new
    options = {}
    options.merge({:public => false}) if options[:private]
    case type
    when "note"
      render api.notes(options)
    when "task"
      render api.tasks(options)
    end
  end

  def self.render(elements)
    elements.each do |element|
      element.render
      puts
    end
  end

  def self.add

  end
end
