require 'rexml/document'
require 'shared/cc_rb_sample.rb'

class CCRBProjectInfo < CCRBSample
  def build_data_map! source
    document = REXML::Document.new(source)
    puts "ready to handle document"
    title_str = ""
    date_str = ""
    document.elements.each('/rss/channel/item/title') do |ele|
      title_str = ele.text
    end
    document.elements.each('/rss/channel/item/pubDate') do |ele|
      date_str= ele.text
    end
    items = title_str.split(" ")
    @data_map[:name] = items[0]
    @data_map[:status] = items[-1]
    @data_map[:build_date] = DateTime.parse(date_str)
  end

end
