require 'server/rayd8orsrvr.rb'
require 'shared/simple_http_sample.rb'
require 'test/unit'
require 'rubygems'
require 'flexmock/test_unit'

class TestRayd8orsrvr < Test::Unit::TestCase

   def setup
     @unit = Rayd8orsrvr.new
     class << @unit
        def public_add_sampler sampler
          add_sampler sampler
        end
     end
   end

   def test_set_port
      @unit.port = 1234
   end

  def test_subscribe_to_all
      observer = Object.new
      class << observer
        def update value
        end
      end
    flexmock(@unit).should_receive(:add_observer).once
    @unit.subscribe_to_all observer
  end

  def test_add_sampler_requires_sampler
    assert_raises(RuntimeError, "AbstractSampler subclass required") do
      @unit.public_add_sampler Object.new
    end 
  end

  def test_add_sampler
      abstract_sampler = AbstractSampler.new
      flexmock(abstract_sampler).should_receive(:assign_rayd8orsrvr).once.with(@unit)
      @unit.public_add_sampler abstract_sampler
  end

  def test_monitor_loop_with_observer_uses_map
      fake_simple_html_sample = SimpleHttpSample.new
      abstract_sampler = AbstractSampler.new
      observer = Object.new
      flexmock(observer).should_receive(:update).once.with(Hash) 
      flexmock(abstract_sampler).should_receive(:do_sample).once.and_return(fake_simple_html_sample)
      @unit.subscribe_to_all observer
      @unit.public_add_sampler abstract_sampler
      @unit.monitor_loop
  end
end
