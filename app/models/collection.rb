class Collection
  include DataMapper::Resource

  # === Properties
  property :id, Integer, :serial => true
  property :title, String, :size => 64, :nullable => false
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
  def title(length)
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