require 'shared/rayd8orsample.rb'

class CCRBSample 
   include Rayd8orSample
  
  def initialize
    super
    @data_map = {:name=>nil, :status => nil, :build_date => nil}
    @data_source_name = "CruiseControl.RB" 
    @data_source_version= "Unknown" 
    define_data_map_methods
  end

end
