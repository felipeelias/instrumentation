require 'test_helper'

class LoadAverageParserTest < Minitest::Test
  include Instrumentation

  def test_parsing_osx_load_average
    result = LoadAverage.parse_osx('{ 1.62 1.59 2.03 }')
    expected = { one: '1.62', five: '1.59', ten: '2.03' }

    assert_equal result, expected
  end
end
