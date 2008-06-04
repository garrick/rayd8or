require 'drb'
require 'drb/observer'
require 'server/abstract_sampler.rb'

class Rayd8orsrvr
  include DRb::DRbObservable 
  attr_accessor :port

  def initialize
    @samplers = Array.new
  end
  def subscribe_to_all observer
    add_observer observer
  end

  def monitor_loop
    @samplers.each do |sampler|  
      changed 
      notify_observers sampler.sample 
    end
  end

  def add_sampler sampler
    raise RuntimeError.new("AbstractSampler subclass required") if not sampler.is_a?(AbstractSampler)   
    sampler.assign_rayd8orsrvr(self) 
    @samplers << sampler
  end
end
