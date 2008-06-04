require 'shared/rayd8orsample.rb'

class WebCCSample 
   include Rayd8orSample
  
  def initialize
    super
    @data_map = {:name=>nil, :status => nil, :last_failed => nil, :last_passed => nil, :build_number => nil}
    @data_source_name = "CruiseControl" 
    @data_source_version= "2.7.1" 
  end

end
