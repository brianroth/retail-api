class Api::V1::HierarchyNodesController < Api::V1::BaseController
  include ActiveHashRelation

  before_action :find_node, only: [:show, :update, :destroy]

  def index
    nodes = apply_filters(HierarchyNode.all, filter_params)
    nodes = paginate(nodes)
    render json: nodes,
      each_serializer: Api::V1::HierarchyNodeSerializer,
      meta: meta_attributes(nodes)
  end

  def show
    render json: @node, serializer: Api::V1::HierarchyNodeSerializer
  end

  def create
    node = HierarchyNode.create(create_params)
    if node.new_record?
      render_with_errors node
    else
      render json: node, serializer: Api::V1::HierarchyNodeSerializer
    end
  end

  def update
    if @node.update_attributes(update_params)
      render json: @node, serializer: Api::V1::HierarchyNodeSerializer
    else
      render_with_errors @node
    end
  end

  def destroy
    if @node.destroy
      head :ok
    else
      render_with_errors @node
    end
  end

  private

  def find_node
    @node = HierarchyNode.find(params[:id])
  end

  def create_params
    params.require(:node).permit(
      :upc, :name, :uom
    )
  end

  def update_params
    params.require(:node).permit(
      :name, :uom
    )
  end
end
