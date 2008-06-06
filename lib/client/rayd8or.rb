require 'drb'
require 'shared/simple_http_sample.rb'

class Rayd8or
include DRbUndumped 
  def update(value) 
    puts "value is a #{value.class}"
    puts "fuck fuck fuck!"
    puts "#{value[:title]} got #{value[:http_status]}"
    #verse = "say #{value.text} returned #{value.code}"
    #system("say #{value}")
  end 
end
