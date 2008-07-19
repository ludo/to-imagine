class Image
  include DataMapper::Resource

  # === Properties
  property :id, Integer, :serial => true
  property :filename, String, :nullable => false
  property :content_type, String, :writer => :private, :nullable => false
  property :size, Integer, :writer => :private, :nullable => false
  property :data, Object, :nullable => false
  property :created_at, DateTime
  property :updated_at, DateTime
  property :collection_id, Integer, :nullable => false
  
  # === Associations
  belongs_to :collection
  
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
end
