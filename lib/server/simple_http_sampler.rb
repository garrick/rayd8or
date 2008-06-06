require 'rubygems'
require 'mechanize'
require 'lib/server/abstract_sampler.rb'
require 'lib/shared/simple_http_sample.rb'

class SimpleHttpSampler < AbstractSampler
  attr_accessor :agent, :title, :url, :text
  attr_reader :response_code

  def initialize
    @agent = WWW::Mechanize.new
    @url = nil
  end

  def load_page_text! 
    @mechanize_page = @agent.get(@url)
    @title = @mechanize_page.title
    @text = @mechanize_page.content
    @response_code = @mechanize_page.code
  end 

protected
  def do_sample
    load_page_text!
    sample = SimpleHttpSample.new
    sample.data_map[:text] = text
    sample.data_map[:title] = title
    sample.data_map[:http_status] = response_code 
    return sample
  end

end
