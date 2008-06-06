require 'shared/web_cc_sample.rb'
require 'test/unit'

class TestWebCCSample< Test::Unit::TestCase

  def setup
    @unit = WebCCSample.new
  end

  def test_data_map
    @unit = WebCCSample.new
    expected_map = {:name=>nil, :status => nil, :last_failed => nil, :last_passed => nil, :build_number => nil}
    assert_equal expected_map, @unit.data_map, "Maps don't match..."
  end

  def test_source_name_and_version
    assert_equal "CruiseControl", @unit.data_source_name
    assert_equal "2.7.1", @unit.data_source_version
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
