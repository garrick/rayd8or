require 'shared/simple_http_sample.rb'
require 'test/unit'

class TestSimpleHttpSample< Test::Unit::TestCase

  def setup
    @unit = SimpleHttpSample.new
  end

  def test_data_map
    expected_map = {:text=>nil, :http_status => nil}
    assert_equal expected_map, @unit.data_map, "Maps don't match..."
  end

  def test_data_source_name_version
    assert_equal "SimpleHttp", @unit.data_source_name
    assert_equal "0.1", @unit.data_source_version
  end
end
