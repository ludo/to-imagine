require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module SizeSpecHelper
  def valid_properties
    { :title => "Tiny",
      :width => 60,
      :height => 100 }
  end
end

describe Size, "with geometry" do
  include SizeSpecHelper
  
  before(:each) do
    @size = Size.new(valid_properties)
  end
  
  it "should display them in a format known to RMagick" do
    @size.geometry.should == "#{valid_properties[:width]}x#{valid_properties[:height]}"
  end

end