require 'drb'
require 'shared/simple_http_sample.rb'

class Rayd8or
include DRbUndumped 
  def update(value) 
    verse =  "#{value[:title]} got #{value[:http_status]}"
    puts "#{verse}"
    system("say #{verse}")
  end 
end
