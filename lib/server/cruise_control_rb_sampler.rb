require 'server/simple_http_sampler.rb'
require 'server/cc_server_sample.rb'

class CruiseControlRBSampler < SimpleHttpSampler

  def initialize
    super
  end

  def parse_rss xml
    projects = Array.new
    
    CCProjectInfo.new
    projects
  end  

end
