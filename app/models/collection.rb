class Collection
  include DataMapper::Resource

  # === Properties
  property :id, Integer, :serial => true
  property :title, String, :size => 64, :unique => true, :nullable => false
  property :public, Boolean, :default => true, :nullable => false
  property :created_at, DateTime
  property :updated_at, DateTime
  
  # === Associations

  # === Instance methods
  
  # Chop title to <tt>length</tt> characters
  #
  # If title is longer than <tt>length</tt> characters, the title will be
  # chopped at <tt>length</tt> characters and appended with '...'. A title
  # shorter than <tt>length</tt> characters will be returned as is.
  #
  # ==== Parameters
  # length<FixNum>:: The maximum length of the returned title
  #
  # ==== Returns
  # String:: The first <tt>length</tt> characters of the title
  #
  # --
  # @api public
  def shortened_title(length = 16)
    str = @title[0..length - 1]
    str += "..." if @title.size > length
    str
  end

  # Return the title when stringified
  #
  # ===== Returns
  # String:: The collection's title
  #
  # --
  # @api public
  def to_s
    @title
  end
end