require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module GeometrySpecHelper
  def valid_properties
    { :name => "tiny",
      :description => "Tiny",
      :width => 60,
      :height => 100 }
  end
end

describe Geometry, "with geometry" do
  include GeometrySpecHelper
  
  before(:each) do
    @geometry = Geometry.new(valid_properties)
  end
  
  it "should display them in a format known to RMagick" do
    @geometry.to_s.should == "#{valid_properties[:width]}x#{valid_properties[:height]}"
  end

end