module Rayd8orSample

  attr_reader :data_source_name, :data_source_version, :data_map
  def initialize
    @data_map = Hash.new
    @data_source_name = "UNDEFINED" 
    @data_source_version= "UNDEFINED" 
  end

  def build_data_map source
    raise RuntimeError.new "Must define!"
  end

  def method_missing(method, *args, &blk)
    return data_map[method] if data_map.has_key? method
    super
  end
end
