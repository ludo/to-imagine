class Size
  include DataMapper::Resource

  # === Properties
  property :id, Integer, :serial => true
  property :title, String, :size => 20, :unique => true, :nullable => false
  property :width, Integer, :nullable => false
  property :height, Integer, :nullable => false
  
  # === Associations
  
  # === Instance Methods
  
  def dimensions
    "#{@width}x#{@height}"
  end
  
  # Return the title when stringified
  #
  # ===== Returns
  # String:: The title
  #
  # --
  # @api public
  def to_s
    @title
  end
end
