require 'server/simple_http_sampler.rb'
require 'server/cc_project_info.rb'
require 'server/cc_rb_project_info.rb'


class CruiseControlSampler < SimpleHttpSampler
 
  @@project_types = {:cc => CCProjectInfo, :ccrb => CCRBProjectInfo }
 
  def initialize server_type
    super()
    @server_type = server_type
  end

  def build_project_info
    raise RuntimeError.new("Unknown CruiseControl server type #{@server_type}") if @@project_types[@server_type].nil?
    return @@project_types[@server_type].new 
  end

  def parse_rss xml
    projects = Array.new
    CCProjectInfo.new
    projects
  end  

end
