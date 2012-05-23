class Asset
  include DataMapper::Resource

  # === Properties
  property :id, Integer, :serial => true
  property :filename, String, :nullable => false
  property :description, String, :size => 128
  property :content_type, String, :writer => :private, :nullable => false
  property :size, Integer, :writer => :private, :nullable => false
  property :data, Object, :nullable => false
  property :created_at, DateTime
  property :updated_at, DateTime
  property :album_id, Integer, :nullable => false

  # === Associations
  belongs_to :album

  # ==== Instance methods

  # Populates attributes with data from a POST params hash
  #
  # TODO This method shouldn't be named data=? Since it's value is used on the
  # input form and that looks bad.
  #
  # ==== Parameters
  # value<Hash>:: Hash containing the file and metadata like the filename and
  # -size.
  #
  # --
  # @api public
  def data=(value)
    # Set metadata on object
    attribute_set(:filename, value[:filename])
    attribute_set(:content_type, value[:content_type])
    attribute_set(:size, value[:size])

    # Store contents of file (may be a String or a StringIO)
    attribute_set(:data, if value[:tempfile].respond_to?(:rewind)
      value[:tempfile].rewind
      value[:tempfile].read
    else
      value[:tempfile]
    end)
  end

  # Get the dimensions of this asset
  #
  # ==== Returns
  # String:: An RMagick compatible geometry string (i.e. '200x200')
  #
  # --
  # @api public
  def geometry
    image = load_image

    "#{image.columns}x#{image.rows}"
  end

  # Resize the asset
  #
  # ==== Parameters
  # geometry<String>:: An RMagick compatible geometry string (i.e. '200x200')
  #
  # ==== Returns
  # <?>:: A resized asset
  #
  # --
  # @api public
  def resize(geometry)
    load_image.change_geometry(geometry) do |width, height, img|
      img.resize(width, height).to_blob
    end
  end

  # Return the image as JPG
  #
  # TODO Conversion if image is NOT jpg
  #
  # ==== Returns
  # What type is it?
  #
  # --
  # @api public
  def to_jpg
    load_image
  end

private

  # Create an +Image+ object from the asset's data
  #
  # ==== Returns
  # Magick::Image:: An +Image+
  #
  # --
  # @api private
  def load_image
    Magick::Image.from_blob(data).first
  end
end
