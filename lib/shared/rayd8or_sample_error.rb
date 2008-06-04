require 'shared/rayd8orsample'

class Rayd8orSampleError < StandardError
  include Rayd8orSample

  def initialize orig_error
    @data_map = {:rayd8or_orig_error => orig_error}
    @data_source_name = "Rayd8orSampleError" 
    @data_source_version= "0.1" 
  end
end
