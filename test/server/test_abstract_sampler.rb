require 'server/abstract_sampler.rb'
require 'shared/simple_http_sample.rb'
require 'test/unit'
require 'rubygems'
require 'flexmock/test_unit'

class TestAbstractSampler < Test::Unit::TestCase

  def setup
    @unit = AbstractSampler.new
    class << @unit
      def public_do_sample
        do_sample
      end
    end
  end

  def test_do_sample_raises_runtime_error
    assert_raises(RuntimeError) do
      @unit.public_do_sample
    end
  end

  def test_sample_with_bad_subclass_does_no_harm_returns_error_class
    sample = @unit.sample
    assert sample.is_a?(Rayd8orSampleError), "We should have Rayd8orSampleError"
    assert sample.rayd8or_orig_error.message =~ /Override and return/
  end

  def test_sample
    @unit = AbstractSampler.new
    class << @unit
      def do_sample
        return SimpleHttpSample.new
      end
    end
    result = @unit.sample
    assert_equal SimpleHttpSample, result.class
  end

  def x_test_assign_rayd8orsrvr_adds_self_as_observer
    fake_server = Rayd8orsrvr.new
    flexmock(fake_server).should_receive(:add_observer).once.with(@unit)
    @unit.assign_rayd8orsrvr fake_server
  end
end
