require 'server/web_cc_project_info.rb'
require 'test/unit'
require 'date'

class TestWebCCProjectInfo< Test::Unit::TestCase

  def setup
    @unit = WebCCProjectInfo.new
  end

  def test_build_data_map
    expected_last_passed = DateTime.parse("12/9/05")
    @unit.build_data_map ugly_raw_html 
    assert_equal "connectfour", @unit.name 
    assert_equal "waiting", @unit.status
    assert_equal nil, @unit.last_failed
    assert_equal expected_last_passed, @unit.last_passed
    assert_equal 0, @unit.build_number
  end

  def test_build_table_array
     rows = @unit.build_table_array ugly_raw_html  
     assert_equal 6, rows.size, "We should have six rows"
  end

  def test_parse_project
    project_html = "<td class=\"data\"><a href=\"buildresults/connectfour\">connectfour</a></td>"
    result = @unit.parse_project project_html
    assert_equal "connectfour", result, "Should have 'connectfour'"
  end

  def test_parse_project_for_nil
    project_html = nil
    result = @unit.parse_project project_html
    assert_equal "UNKNOWN PROJECT", result, "Should have UNKNOWN PROJECT" 
  end

  def test_parse_project_for_bad_data
    project_html = "<td>no link or anything </td>"
    result = @unit.parse_project project_html
    assert_equal "UNKNOWN PROJECT", result, "Should have UNKNOWN PROJECT" 
  end

  def test_parse_status_waiting
    status_html ="<td class=\"data date status-dull\" title='(6:31:34 PM) next build in 5 minutes ' >waiting  <em>(6:31 PM)</em></td>"
    result = @unit.parse_status status_html 
    assert_equal "waiting", result, "Should have 'waiting'"
  end

  def test_parse_status_passed
    status_html ="<td class=\"index-passed\" align=\"center\">passed</td>"
    result = @unit.parse_status status_html 
    assert_equal "passed", result, "Should have 'passed'"
  end

  def test_parse_status_failed
    status_html ="<td class=\"index-failed\" align=\"center\">failed</td>"
    result = @unit.parse_status status_html 
    assert_equal "failed", result, "Should have 'failed'"
  end

  def test_parse_last_date_for_nil
    last_date_html = "<td class=\"data date failure\"></td>"
    result = @unit.parse_last_date last_date_html
    assert_equal nil, result, "Should have nil for last date"
  end

  def test_parse_last_date_for_indicated_date
    expected_date_str = "04/09/2007 05:06:21"
    expected_date = DateTime.parse(expected_date_str)
    last_date_html = "<td align=\"center\">" + expected_date_str  +"</td>"
    result = @unit.parse_last_date last_date_html
    assert_equal expected_date, result, "Should have nil for last failure"
  end

  def test_parse_last_build_number
    expected_build = "build.0"
    last_build_html = "<td class=\"data\">" + expected_build + "</td>"
    result = @unit.parse_last_build_number last_build_html
    assert_equal 0, result, "Should have Fixnum 0 for last build"

  end

  def ugly_raw_html
    ugly =<<UGLY_RAW_HTML
 <tr class="odd-row ">

              <td class="data"><a href="buildresults/connectfour">connectfour</a></td>
              <td class="data date status-dull" title='(6:31:34 PM) next build in 5 minutes ' >waiting  <em>(6:31 PM)</em></td>
              <td class="data date failure"></td>
              <td class="data date">12/9/05</td>
              <td class="data">build.0</td>

              
              <td class="data"><input id="force_connectfour" type="button"
                                      onclick="callServer('http://192.168.254.71:8000/invoke?operation=build&objectname=CruiseControl+Project%3Aname%3Dconnectfour', 'connectfour')"
                                      value="Build"/></td>

              
            </tr>
UGLY_RAW_HTML
  end

end
