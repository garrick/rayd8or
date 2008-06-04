require 'rubygems'
require 'hpricot'
require 'shared/web_cc_sample.rb'

class WebCCProjectInfo < WebCCSample
  @@SUCCESS_STATUS = [:passed, :waiting]
  @@LIMBO_STATUS = [:waiting]
  @@FAIL_STATUS = [:failed]
  @@recognized_status = @@SUCCESS_STATUS + @@LIMBO_STATUS + @@FAIL_STATUS
#  attr_accessor :name, :status, :last_failed, :last_passed, :build_number

  def build_data_map source
    rows = build_table_array source
    @data_map[:name] = parse_project rows[0]
    @data_map[:status] = parse_status rows[1]
    @data_map[:last_failed] = parse_last_date rows[2]
    @data_map[:last_passed] = parse_last_date rows[3]
    @data_map[:build_number] = parse_last_build_number rows[4]
  end

  def build_table_array html_row
    tdregstr = "\<td.*\>\.*\<\/td\>"
    clean_row = html_row.gsub("\n","")
    clean_row = clean_row.gsub("</td>","</td>\n")
    td_array = clean_row.scan(/\<td.*td\>.*/) 
  end

  def parse_project html_string
    project_name = (Hpricot.XML(html_string)/:a).text.to_s.strip
    project_name.empty? ? "UNKNOWN PROJECT" : project_name
    rescue 
    "UNKNOWN PROJECT"
  end
  
  def parse_status html_string
    status_raw = (Hpricot.XML(html_string)/:td).text.to_s.strip
    status = status_raw.split(" ").each do |stat| 
       break(stat) if @@recognized_status.include? stat.to_sym
    end
    status.empty? ? "UNKNOWN STATUS" : status
    rescue 
    "UNKNOWN STATUS"
  end

  def parse_last_date html_string
    DateTime.parse((Hpricot.XML(html_string)/:td).text.to_s.strip)
    rescue 
      nil
  end

  def parse_last_build_number html_string
    (Hpricot.XML(html_string)/:td).text.to_s.strip.sub!("build.","").to_i
    rescue
      -1
  end

end
