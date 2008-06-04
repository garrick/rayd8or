require 'shared/rayd8orsample.rb'
require 'test/unit'

class TestRayd8orSample< Test::Unit::TestCase

  def test_build_data_map_throws_runtime
    unit = Object.new
    class << unit
      include Rayd8orSample
    end
    assert_raises(RuntimeError) do
      unit.build_data_map nil
    end
  end

  def test_method_missing_uses_data_map
    unit = Object.new
    class << unit
      include Rayd8orSample
      def data_map
        {:special_thing => "I am special"}
      end
    end
    assert_equal "I am special", unit.special_thing 
  end

  def test_method_missing_calls_super_if_no_data_in_map
    unit = Object.new
    class << unit
      include Rayd8orSample
    end
    assert_raises(NoMethodError) do
      unit.special_thing
    end
  end
end
