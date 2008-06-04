require 'server/simple_http_sampler.rb'
require 'server/web_cc_project_info.rb'
require 'server/cc_rb_project_info.rb'
require 'shared/web_cc_sample.rb'
require 'shared/cc_rb_sample.rb'


class CruiseControlSampler < SimpleHttpSampler
 
  @@sample_types = {:cc => WebCCSample, :ccrb => CCRBSample }
 
  def initialize server_type
    super()
    @server_type = server_type
  end

  def build_project_info
    raise RuntimeError.new("Unknown CruiseControl server type #{@server_type}") if @@sample_types[@server_type].nil?
    return @@sample_types[@server_type].new 
  end

  def parse_rss xml
    projects = Array.new
    WebCCProjectInfo.new
    projects
  end  

end
