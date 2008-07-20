require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Assets, "index action" do
  before(:each) do
    dispatch_to(Assets, :index)
  end
end

describe Assets, "show action" do
  it "with :asset_id and :filename should return the original asset" do
    
  end
end