require 'shared/rayd8or_sample_error.rb'

class AbstractSampler

  def initialize
    @rayd8orsrvr = nil
  end

  def sample
    return do_sample
  rescue StandardError => error
    return Rayd8orSampleError.new(error) 
  end

  def assign_rayd8orsrvr rayd8orsrvr
    @rayd8orsrvr = rayd8orsrvr
  end

protected
  def do_sample
    raise RuntimeError.new "I'm abstract.  Override and return an instance of Rayd8orSample.class."    
  end

end
