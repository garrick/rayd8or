require 'server/cc_project_info.rb'
require 'test/unit'
require 'date'

class TestCCProjectInfo< Test::Unit::TestCase

  def setup
    @unit = CCProjectInfo.new
  end

  def test_build_from_title
    title = "connectfour passed Fri, 09 Dec 2005 12:21:03 -0800"
    expected_date = DateTime.parse("Fri, 09 Dec 2005 12:21:03 -0800")
    @unit.parse title
    assert_equal "connectfour", @unit.name 
    assert_equal "passed", @unit.status
    assert_equal expected_date, @unit.date
  end

end
