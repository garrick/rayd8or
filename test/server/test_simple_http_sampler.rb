require 'server/simple_http_sampler.rb'
require 'test/unit'
require 'ostruct'
require 'flexmock/test_unit'

class TestSimpleHttpSampler < Test::Unit::TestCase

  def setup
    @unit = SimpleHttpSampler.new
    class << @unit
      def public_do_sample
        do_sample
      end
    end
  end


  def test_agent_is_mechanize_by_default
    assert_equal WWW::Mechanize, @unit.agent.class  
  end

  def test_load_page_text!
    fake_page = OpenStruct.new
    fake_page.code = 200
    class << fake_page
      def to_s
        "Fake page text here"
      end
    end
    agent_stub = OpenStruct.new
    agent_stub.get = fake_page
    @unit.agent = agent_stub
    @unit.url = "http://www.google.com"
    @unit.load_page_text! 
    assert_equal "Fake page text here", @unit.page_text
  end

  def test_do_sample
    flexmock(@unit).should_receive(:load_page_text!).once
    flexmock(@unit).should_receive(:page_text).once.and_return("foo")
    flexmock(@unit).should_receive(:response_code).once.and_return(200)
    result = @unit.public_do_sample 
  end
end
