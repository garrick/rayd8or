require 'drb'

class Rayd8or
include DRbUndumped 
  def update(value) 
    p value 
    system("say #{value}")
  end 
end
