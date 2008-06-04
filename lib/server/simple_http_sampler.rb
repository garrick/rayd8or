require 'rubygems'
require 'mechanize'
require 'lib/server/abstract_sampler.rb'
require 'lib/shared/simple_http_sample.rb'

class SimpleHttpSampler < AbstractSampler
  attr_accessor :agent, :page_text, :url
  attr_reader :response_code

  def initialize
    @agent = WWW::Mechanize.new
    @url = nil
  end

  def load_page_text! 
    @mechanize_page = @agent.get(@url)
    @page_text = @mechanize_page.to_s
    @response_code = @mechanize_page.code
  end 

protected
  def do_sample
    load_page_text!
    sample = SimpleHttpSample.new
    sample.data_map[:text] = page_text
    sample.data_map[:http_status] = response_code 
  end

end
