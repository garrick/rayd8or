require 'server/cruise_control_sampler.rb'
require 'test/unit'
require 'flexmock/test_unit'

class TestCruiseControlSampler < Test::Unit::TestCase

  def setup
    @unit = CruiseControlSampler.new
  end


  def test_proper_extention_and_initialization
    assert @unit.is_a? SimpleHttpSampler
    assert_not_nil @unit.agent
  end

  def test_parse_vs_standard_page
    fake_page = Object.new
    fake_agent = WWW::Mechanize.new
    flexmock(fake_agent).should_receive(:get).once.with('http://localhost:8080').and_return {
  fake_page
}
    @unit.agent = fake_agent
    @unit.load_page_text! 'http://localhost:8080'
  end

end
