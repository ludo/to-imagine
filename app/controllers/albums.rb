class Albums < Application
  # provides :xml, :yaml, :js

  def index
    @albums = Album.all
    display @albums
  end

  def show
    @album = Album.get(params[:id])
    raise NotFound unless @album
    display @album
  end

  def new
    only_provides :html
    @album = Album.new
    render
  end

  def edit
    only_provides :html
    @album = Album.get(params[:id])
    raise NotFound unless @album
    render
  end

  def create
    @album = Album.new(params[:album])
    if @album.save
      redirect url(:album, @album)
    else
      render :new
    end
  end

  def update
    @album = Album.get(params[:id])
    raise NotFound unless @album
    if @album.update_attributes(params[:album]) || !@album.dirty?
      redirect url(:album, @album)
    else
      raise BadRequest
    end
  end

  def destroy
    @album = Album.get(params[:id])
    raise NotFound unless @album
    if @album.destroy
      redirect url(:album)
    else
      raise BadRequest
    end
  end

end
