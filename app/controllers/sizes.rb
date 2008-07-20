class Sizes < Application
  # provides :xml, :yaml, :js

  def index
    @sizes = Size.all(:order => [:description])
    display @sizes
  end

  def new
    only_provides :html
    @size = Size.new
    render
  end

  def edit
    only_provides :html
    @size = Size.get(params[:id])
    raise NotFound unless @size
    render
  end

  def create
    @size = Size.new(params[:size])
    if @size.save
      redirect url(:sizes)
    else
      render :new
    end
  end

  def update
    @size = Size.get(params[:id])
    raise NotFound unless @size
    if @size.update_attributes(params[:size]) || !@size.dirty?
      redirect url(:sizes)
    else
      raise BadRequest
    end
  end

  def destroy
    @size = Size.get(params[:id])
    raise NotFound unless @size
    if @size.destroy
      redirect url(:size)
    else
      raise BadRequest
    end
  end

end
