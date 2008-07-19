require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module AlbumSpecHelper
  def valid_properties
    { :title => "Hawaii Holiday" }
  end
end

describe Album do
  include AlbumSpecHelper

  before(:each) do
    Album.all.destroy!
  end
  
  describe "with a title" do
    before(:each) do
      @album = Album.new(valid_properties)
    end    
    
    it "should be valid" do
      @album.should be_valid
    end
    
    it "should be unique" do
      @album.save
      duplicate = Album.new(valid_properties)
      duplicate.should_not be_valid
      duplicate.errors.on(:title).should_not be_nil
    end
    
    it "should not exceed the maximum length of 64 characters" do
      @album.title = "abc" * 30
      @album.should_not be_valid
      @album.errors.on(:title).should_not be_nil
    end
    
    it "should return the title when stringified" do
      @album.to_s.should == @album.title
    end
  end
  
  describe "without a title" do
    before(:each) do
      @album = Album.new(valid_properties.except(:title))
    end    
    
    it "should not be valid" do
      @album.should_not be_valid
      @album.errors.on(:title).should_not be_nil
    end
  end
  
  describe "that is public" do
    before(:each) do
      @album = Album.new(valid_properties.merge(:public => true))
    end
    
    it "should be valid" do
      @album.should be_valid
    end
    
    it "should know that it is public" do
      @album.public.should == true
    end
  end

  describe "that is private" do
    before(:each) do
      @album = Album.new(valid_properties.merge(:public => false))
    end
    
    it "should be valid" do
      @album.should be_valid
    end
    
    it "should know that it is private" do
      @album.public.should == false
    end
  end
end

describe Album, "when shortened_title" do
  include AlbumSpecHelper

  describe "is called with a long title" do
    before(:each) do
      @album = Album.new(valid_properties.merge(:title => "The Little Large Vacation At the Beach in Hawaii!"))
    end
  
    it "should be shortened" do
      @album.shortened_title.size.should == 19 # 16 + 3 from '...'
    end
  
    it "should be appended with '...'" do
      @album.shortened_title[-3,3].should == "..."
    end
    
    it "should allow a custom length" do
      @album.shortened_title(6).should == "The Li..."
    end
  end
  
  describe "is called with a short title" do
    before(:each) do
      @album = Album.new(valid_properties.merge(:title => "Hawaii"))
    end

    it "should return the title as is" do
      @album.shortened_title(16).should == @album.title
    end
  end
end