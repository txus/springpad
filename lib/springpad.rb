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

  def self.add(type, options)
    cli = Springpad::CLI.new
    options = {}
    options.merge({:public => false}) if options[:private]
    contents = cli.edit

    api = Springpad::API.new
    case type
    when "note"
      p api.add_note(contents, options)
    when "task"
      p api.add_task(contents, options)
    end
  end
end
