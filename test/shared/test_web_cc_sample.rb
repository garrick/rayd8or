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
end
