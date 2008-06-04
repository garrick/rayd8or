require 'shared/cc_rb_sample.rb'
require 'test/unit'

class TestCCRBSample< Test::Unit::TestCase

  def setup
    @unit = CCRBSample.new
  end

  def test_data_map
    expected_map = {:name=>nil, :status => nil, :build_date => nil}
    assert_equal expected_map, @unit.data_map, "Maps don't match..."
  end

  def test_source_name_and_version
    assert_equal "CruiseControl.RB", @unit.data_source_name 
    assert_equal "Unknown", @unit.data_source_version
  end
end
