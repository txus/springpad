require 'test_helper'

module Springpad::Blocks
  describe Note do
    describe '.process' do
      let(:json) do
        [
          {
            "name" => "Foo",
            "properties" => {
              "text" => "Foo bar baz"
            }
          },

          {
            "name" => "Bar",
            "properties" => {
              "text" => "Foo bar baz"
            }
          }
        ]
      end

      it 'processes JSON notes and outputs Note objects' do
        notes = Note.process(json)
        notes.length.must_equal 2

        notes.first.name.must_equal "Foo"
        notes.first.text.must_equal "Foo bar baz"

        notes.last.name.must_equal "Bar"
        notes.last.text.must_equal "Foo bar baz"
      end
    end
  end
end
