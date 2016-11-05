require 'test_helper'

class BoundedArrayTest < Minitest::Test
  include Instrumentation

  def test_adds_to_array
    array = BoundedArray.new(2, [:value0])
    array = array << :value1

    assert_equal array.items, [:value0, :value1]

    array = array << :value2
    assert_equal array.items, [:value1, :value2]
  end
end
