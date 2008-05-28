require 'drb'
require 'drb/observer'

class Rayd8orsrvr
  include DRb::DRbObservable 
  VERSION = '1.0.0'
  attr_accessor :port
end
