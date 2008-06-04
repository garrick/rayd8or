require 'shared/cc_rb_sample.rb'
require 'test/unit'

class TestCCRBSample< Test::Unit::TestCase
  def test_data_map
    unit = CCRBSample.new
    expected_map = {:name=>nil, :status => nil, :build_date => nil}
    assert_equal expected_map, unit.data_map, "Maps don't match..."
  end
end
