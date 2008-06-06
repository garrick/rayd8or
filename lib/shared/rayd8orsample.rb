module Rayd8orSample

  attr_reader :data_source_name, :data_source_version, :data_map

  def self.extended(base)
    @data_map = Hash.new
    @data_source_name = "UNDEFINED" 
    @data_source_version= "UNDEFINED" 
  end

  def build_data_map source
    raise RuntimeError.new("Must define!")
  end

  def define_data_map_methods
      @data_map.keys.each do |value|
        build_a_method(value) { 
          str = "@data_map[:#{value}]"
         eval(str)
        }
      end
  end

  private
  def build_a_method name, &block
    self.class.send(:define_method, name, block)
  end 

end
