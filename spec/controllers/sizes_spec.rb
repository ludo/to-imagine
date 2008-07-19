require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Sizes, "index action" do
  before(:each) do
    dispatch_to(Sizes, :index)
  end
end