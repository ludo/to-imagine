class Size
  include DataMapper::Resource

  # === Properties
  property :id, Integer, :serial => true
  property :name, String, :size => 16, :unique => true, :nullable => false
  property :description, String, :size => 32, :unique => true, :nullable => false
  property :width, Integer, :nullable => false
  property :height, Integer, :nullable => false
  
  # === Associations
  
  # === Instance Methods
  
  def name=(value)
    attribute_set(:name, value.downcase)
  end
  
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
  def to_s
    "#{@width}x#{@height}"
  end
end
