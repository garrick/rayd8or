require 'shared/simple_http_sample.rb'
require 'test/unit'

class TestSimpleHttpSample< Test::Unit::TestCase

  def setup
    @unit = SimpleHttpSample.new
  end

  def test_data_map
    expected_map = {:text=>nil, :title => nil, :http_status => nil}
    assert_equal expected_map, @unit.data_map, "Maps don't match..."
  end

  def test_data_source_name_version
    assert_equal "SimpleHttp", @unit.data_source_name
    assert_equal "0.1", @unit.data_source_version
  end

  def test_accessors_for_all_data_map_values
    valid_send = 0
    @unit.data_map.keys.each do |accessor| 
      assert_nil @unit.send(accessor, nil), \
        "SimpleHttpSample does not respond to message '#{accessor}'"
      valid_send += 1
    end
    assert_equal valid_send, @unit.data_map.size, "Should respond to each data_map entry"
  end
end
