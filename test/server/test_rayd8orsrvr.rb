require 'server/rayd8orsrvr.rb'
require 'test/unit'

class TestRayd8orsrvr < Test::Unit::TestCase

   def setup
     @unit = Rayd8orsrvr.new
   end

   def test_set_port
      @unit.port = 1234
   end

   def test_includes_observable
      observer = Object.new
      class << observer
        def update value
        end
      end
      @unit.add_observer observer
   end
end
