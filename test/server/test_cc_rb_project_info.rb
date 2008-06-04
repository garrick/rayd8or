require 'server/cc_rb_project_info.rb'
require 'test/unit'
require 'date'

class TestCCRBProjectInfo< Test::Unit::TestCase

  def setup
    @unit = CCRBProjectInfo.new
  end

  def test_parse
    expected_date = DateTime.parse("Thu, 24 Apr 2008 22:07:45 Z")
    @unit.build_data_map!(build_cc_ruby_rss_single_sample)
    assert_equal "CruiseControlRB", @unit.name 
    assert_equal "success", @unit.status
    assert_equal expected_date, @unit.build_date
  end

  def build_cc_ruby_rss_single_sample
    data =<<END_OF_XML_BLOCK
<rss version="2.0">
  <channel>
    <title>CruiseControl RSS feed for CruiseControlRB</title>
    <link>http://cruisecontrolrb.thoughtworks.com/projects/CruiseControlRB</link>
    <language>en-us</language>
    <ttl>10</ttl>
    <item>
      <title>CruiseControlRB build 623 success</title>
      <description>&lt;pre&gt;New revision 623 detected
Revision 623 committed by alexeyv on 2008-04-24 22:05:32
oops, forgot to change the version number
  M /trunk/lib/cruise_control/version.rb
Revision 621 committed by alexeyv on 2008-04-24 19:40:31
Fixing a curious bug in Subversion unit tests, which is not reproducible when you run it in a checked out copy of source
  M /trunk/test/unit/subversion_test.rb

&lt;/pre&gt;</description>
      <pubDate>Thu, 24 Apr 2008 22:07:45 Z</pubDate>
      <guid>http://cruisecontrolrb.thoughtworks.com/builds/CruiseControlRB/623</guid>
      <link>http://cruisecontrolrb.thoughtworks.com/builds/CruiseControlRB/623</link>
    </item>
  </channel>

</rss>
END_OF_XML_BLOCK
  end
end
