require 'tempfile'

module Springpad
  class CLI
    # Public: Edits a file with $EDITOR and returns the contents.
    #
    # Returns an Array with the first line and an array of the other lines.
    def edit
      temp_file = Tempfile.new('block')
      system("$EDITOR #{temp_file.path}")
      contents = temp_file.read.chomp.split("\n").reject(&:empty?).map(&:strip)
      [contents.first, contents[1..-1]]
    end
  end
end
