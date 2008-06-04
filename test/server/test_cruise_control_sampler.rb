require 'server/cruise_control_sampler.rb'
require 'server/web_cc_project_info.rb'
require 'shared/rayd8orsample.rb'
require 'test/unit'
require 'rubygems'
require 'flexmock/test_unit'

class TestCruiseControlSampler < Test::Unit::TestCase

  def test_proper_extention_and_initialization
    @unit = CruiseControlSampler.new(:cc)
    assert @unit.is_a?(SimpleHttpSampler)
    assert_not_nil @unit.agent
  end

  def test_build_project_info_for_java_version
    @unit = CruiseControlSampler.new(:cc)
    assert @unit.build_project_info.is_a?(WebCCSample)
  end

  def test_build_project_info_for_ruby_version
    @unit = CruiseControlSampler.new(:ccrb)
    assert @unit.build_project_info.is_a?(Rayd8orSample) 
  end

  def test_build_project_info_blows_up
    assert_raise RuntimeError do 
      CruiseControlSampler.new(:faketype).build_project_info
    end
  end

  #elements = somepage.search("//tr[@class='odd-row ']")
  #elements = somepage.search("//tr[@class='even-row ']")
  #elements.each do |x| puts x.to_html end #Get's the string
  def test_parse_vs_standard_page
    @unit = CruiseControlSampler.new(:cc)
    fake_page = Object.new
    fake_agent = WWW::Mechanize.new
    flexmock(fake_agent).should_receive(:get).once.with('http://localhost:8080/rss').and_return {
  fake_page
}
    @unit.agent = fake_agent
    @unit.load_page_text! 'http://localhost:8080/rss'
  end

  def x_test_test_xml_parsing
    @unit = CruiseControlSampler.new(:cc)
    ccproject_info = @unit.parse_rss  build_single_project_xml_sample
    assert ccproject_info.all? { |x| x.is_a? CCProjectInfo }
  end

  def build_single_project_xml_sample
    data = <<END_OF_XML_BLOCK    
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<channel>
<title>CruiseControl Results</title>
<link>http://localhost:8080</link>
<description>Summary of the project build results.</description>
<language>en-us</language>
<item>
<title>connectfour passed Fri, 09 Dec 2005 12:21:03 -0800</title>
<description>Build passed</description>
<pubDate>Fri, 09 Dec 2005 12:21:03 -0800</pubDate>
<link>http://localhost:8080/buildresults/connectfour</link>
</item>
</channel>
</rss>
END_OF_XML_BLOCK
    return data
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
