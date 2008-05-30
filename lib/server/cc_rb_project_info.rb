require 'server/cc_project_info.rb'

class CCRBProjectInfo < CCProjectInfo

  def parse xml
    items = title.split(" ")
    @name = items[0]
    @status = items[1]
    @date = DateTime.parse(items[2..-1].join(" "))
  end

end
