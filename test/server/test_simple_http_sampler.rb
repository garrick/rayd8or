require 'server/simple_http_sampler.rb'
require 'test/unit'

class TestSimpleHttpSampler < Test::Unit::TestCase

  def setup
    @unit = SimpleHttpSampler.new
  end


  def test_agent_is_mechanize_by_default
    assert_equal WWW::Mechanize, @unit.agent.class  
  end

  def test_load_page_text!
    agent_stub = Object.new
    class << agent_stub
      def get url
      "Fake page text here"
      end
    end
    @unit.agent = agent_stub
    @unit.load_page_text! "http://www.google.com"
    assert_equal "Fake page text here", @unit.page_text
  end

end
