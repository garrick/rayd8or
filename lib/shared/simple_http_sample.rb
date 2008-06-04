require 'shared/rayd8orsample.rb'

class SimpleHttpSample 
   include Rayd8orSample
  
  def initialize
    super
    @data_map = {:text => nil, :http_status => nil}
    @data_source_name = "SimpleHttp" 
    @data_source_version= "0.1" 
  end

end
