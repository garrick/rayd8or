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

  def test_define_data_map_methods
    unit = Object.new
    class << unit
      include Rayd8orSample
      def monkeypatch_datamap 
        @data_map = {:special_thing => "I am special"}
      end
    end
    unit.monkeypatch_datamap
    unit.define_data_map_methods
    assert_equal "I am special", unit.special_thing 
  end


end
