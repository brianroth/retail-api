class Api::V1::ItemsController < Api::V1::BaseController
  include ActiveHashRelation
  before_action :find_item, only: [:show, :update, :destroy]

  def index
    items = apply_filters(Item.all, filter_params)
    items = items.where(brand_id: filter_params[:brand_id]) if filter_params[:brand_id]
    items = items.where(hierarchy_node_id: filter_params[:hierarchy_node_id]) if filter_params[:hierarchy_node_id]
    items = paginate(items)

    render json: items,
      each_serializer: Api::V1::ItemSerializer,
      meta: meta_attributes(items)
  end

  def show
    render json: @item, serializer: Api::V1::ItemSerializer
  end

  def create
    item = Item.create(create_params)
    if item.new_record?
      render_with_errors item
    else
      render json: item, serializer: Api::V1::ItemSerializer
    end
  end

  def update
    if @item.update_attributes(update_params)
      render json: @item, serializer: Api::V1::ItemSerializer
    else
      render_with_errors @item
    end
  end

  def destroy
    if @item.destroy
      head :ok
    else
      render_with_errors @item
    end
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def create_params
    params.require(:item).permit(
      :upc, :name, :uom
    )
  end

  def update_params
    params.require(:item).permit(
      :name, :uom
    )
  end
end
