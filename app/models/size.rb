class Size
  include DataMapper::Resource

  # === Properties
  property :id, Integer, :serial => true
  property :title, String, :size => 20, :unique => true, :nullable => false
  property :width, Integer, :nullable => false
  property :height, Integer, :nullable => false
  
  # === Associations
  
  # === Instance Methods
  
  # Geometry string for use with RMagick
  #
  # A geometry string is often used by RMagick. This method makes it easy
  # to create a geometry string. For a full explanation of geometry strings in
  # Rmagick see: 
  # http://studio.imagemagick.org/RMagick/doc/imusage.html#geometry
  #
  # ==== Returns
  # String:: RMagick compatible geometry string
  #
  # --
  # @api public
  def geometry
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
