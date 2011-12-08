require 'test_helper'

module Springpad::Blocks
  describe Task do
    describe '.process' do
      let(:json) do
        [
          {
            "name" => "Foo",
            "properties" => {
              "description" => "Foo bar baz",
              "category" => {
                "name" => "Learning"
              }
            }
          },

          {
            "name" => "Bar",
            "properties" => {
              "description" => "Foo bar baz",
              "category" => {
                "name" => "Learning"
              }
            }
          }
        ]
      end

      it 'processes JSON tasks and outputs Task objects' do
        tasks = Task.process(json)
        tasks.length.must_equal 2

        tasks.first.name.must_equal "Foo"
        tasks.first.description.must_equal "Foo bar baz"
        tasks.first.category.must_equal "Learning"

        tasks.last.name.must_equal "Bar"
        tasks.last.description.must_equal "Foo bar baz"
        tasks.last.category.must_equal "Learning"
      end
    end
  end
end
