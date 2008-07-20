class Assets < Application
  # provides :xml, :yaml, :js

  def index
    @assets = Asset.all
    display @assets
  end

  def show
    provides :html, :jpg
    
    @asset = Asset.get(params[:id] || params[:asset_id])
    raise NotFound unless @asset
    
    case content_type
    when :jpg
      if params[:size]
        size = Size.first(:title => params[:size])
        raise NotFound unless size
        data = @asset.resize(size.geometry)
      else
        data = @asset.data
      end
      
      if params[:filename] && @asset.filename == "#{params[:filename]}.#{params[:extension]}"
        send_data(data, 
          :filename => @asset.filename, 
          :type => @asset.content_type, 
          :disposition => "inline"
        )
      end
    else
      display @asset
    end
  end

  def new
    only_provides :html
    @asset = Asset.new
    render
  end

  def edit
    only_provides :html
    @asset = Asset.get(params[:id])
    raise NotFound unless @asset
    render
  end

  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      redirect url(:asset, @asset)
    else
      render :new
    end
  end

  def update
    @asset = Asset.get(params[:id])
    raise NotFound unless @asset
    if @asset.update_attributes(params[:asset]) || !@asset.dirty?
      redirect url(:asset, @asset)
    else
      raise BadRequest
    end
  end

  def destroy
    @asset = Asset.get(params[:id])
    raise NotFound unless @asset
    if @asset.destroy
      redirect url(:asset)
    else
      raise BadRequest
    end
  end

end
