require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Collections, "index action" do
  before(:each) do
    dispatch_to(Collections, :index)
  end
end