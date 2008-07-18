require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module CollectionSpecHelper
  def valid_properties
    { :title => "Hawaii Holiday" }
  end
end

describe Collection do
  include CollectionSpecHelper

  before(:each) do
    Collection.all.destroy!
  end
  
  describe "with a title" do
    before(:each) do
      @collection = Collection.new(valid_properties)
    end    
    
    it "should be valid" do
      @collection.should be_valid
    end
    
    it "should be unique" do
      @collection.save
      duplicate = Collection.new(valid_properties)
      duplicate.should_not be_valid
      duplicate.errors.on(:title).should_not be_nil
    end
    
    it "should not exceed the maximum length of 64 characters" do
      @collection.title = "abc" * 30
      @collection.should_not be_valid
      @collection.errors.on(:title).should_not be_nil
    end
    
    it "should return the title when stringified" do
      @collection.to_s.should == @collection.title
    end
  end
  
  describe "without a title" do
    before(:each) do
      @collection = Collection.new(valid_properties.except(:title))
    end    
    
    it "should not be valid" do
      @collection.should_not be_valid
      @collection.errors.on(:title).should_not be_nil
    end
  end
  
  describe "that is public" do
    before(:each) do
      @collection = Collection.new(valid_properties.merge(:public => true))
    end
    
    it "should be valid" do
      @collection.should be_valid
    end
    
    it "should know that it is public" do
      @collection.public.should == true
    end
  end

  describe "that is private" do
    before(:each) do
      @collection = Collection.new(valid_properties.merge(:public => false))
    end
    
    it "should be valid" do
      @collection.should be_valid
    end
    
    it "should know that it is private" do
      @collection.public.should == false
    end
  end
end