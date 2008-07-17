class Collections < Application
  # provides :xml, :yaml, :js

  def index
    @collections = Collection.all
    display @collections
  end

  def show
    @collection = Collection.get(params[:id])
    raise NotFound unless @collection
    display @collection
  end

  def new
    only_provides :html
    @collection = Collection.new
    render
  end

  def edit
    only_provides :html
    @collection = Collection.get(params[:id])
    raise NotFound unless @collection
    render
  end

  def create
    @collection = Collection.new(params[:collection])
    if @collection.save
      redirect url(:collection, @collection)
    else
      render :new
    end
  end

  def update
    @collection = Collection.get(params[:id])
    raise NotFound unless @collection
    if @collection.update_attributes(params[:collection]) || !@collection.dirty?
      redirect url(:collection, @collection)
    else
      raise BadRequest
    end
  end

  def destroy
    @collection = Collection.get(params[:id])
    raise NotFound unless @collection
    if @collection.destroy
      redirect url(:collection)
    else
      raise BadRequest
    end
  end

end
