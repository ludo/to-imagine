class Images < Application
  # provides :xml, :yaml, :js

  def index
    @images = Image.all
    display @images
  end

  def show
    provides :html, :jpg
    
    @image = Image.get(params[:id] || params[:image_id])
    raise NotFound unless @image
    
    case content_type
    when :jpg
      if params[:size]
        size = Size.first(:title => params[:size])
        image = @image.resize(size.geometry)
      else
        image = @image.data
      end
      
      if params[:filename] && @image.filename == "#{params[:filename]}.#{params[:extension]}"
        send_data(image, 
          :filename => @image.filename, 
          :type => @image.content_type, 
          :disposition => "inline"
        )
      end
    else
      display @image
    end
  end

  def new
    only_provides :html
    @image = Image.new
    render
  end

  def edit
    only_provides :html
    @image = Image.get(params[:id])
    raise NotFound unless @image
    render
  end

  def create
    @image = Image.new(params[:image])
    if @image.save
      redirect url(:image, @image)
    else
      render :new
    end
  end

  def update
    @image = Image.get(params[:id])
    raise NotFound unless @image
    if @image.update_attributes(params[:image]) || !@image.dirty?
      redirect url(:image, @image)
    else
      raise BadRequest
    end
  end

  def destroy
    @image = Image.get(params[:id])
    raise NotFound unless @image
    if @image.destroy
      redirect url(:image)
    else
      raise BadRequest
    end
  end

end
