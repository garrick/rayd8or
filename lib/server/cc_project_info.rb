class CCProjectInfo
  attr_accessor :name, :status, :date

  def parse title
    items = title.split(" ")
    @name = items[0]
    @status = items[1]
    @date = DateTime.parse(items[2..-1].join(" "))
  end

end
