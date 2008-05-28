require 'rubygems'
require 'mechanize'

class SimpleHttpSampler
  attr_accessor :agent, :page_text

  def initialize
    @agent = WWW::Mechanize.new
  end
  def load_page_text! url
    @mechanize_page = @agent.get(url)
    @page_text = @mechanize_page.to_s
  end 

end
