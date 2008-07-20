class Geometries < Application
  # provides :xml, :yaml, :js

  def index
    @geometries = Geometry.all(:order => [:description])
    display @geometries
  end

  def new
    only_provides :html
    @geometry = Geometry.new
    render
  end

  def edit
    only_provides :html
    @geometry = Geometry.get(params[:id])
    raise NotFound unless @geometry
    render
  end

  def create
    @geometry = Geometry.new(params[:geometry])
    if @geometry.save
      redirect url(:geometries)
    else
      render :new
    end
  end

  def update
    @geometry = Geometry.get(params[:id])
    raise NotFound unless @geometry
    if @geometry.update_attributes(params[:geometry]) || !@geometry.dirty?
      redirect url(:geometries)
    else
      raise BadRequest
    end
  end

  def destroy
    @geometry = Geometry.get(params[:id])
    raise NotFound unless @geometry
    if @geometry.destroy
      redirect url(:geometry)
    else
      raise BadRequest
    end
  end

end
