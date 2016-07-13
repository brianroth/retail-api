class Api::V1::BrandsController < Api::V1::BaseController
  include ActiveHashRelation
  before_action :find_brand, only: [:show, :items, :update, :destroy]

  def index
    brands = apply_filters(Brand.all, filter_params)
    brands = paginate(brands)
    render json: brands,
      each_serializer: Api::V1::BrandSerializer,
      meta: meta_attributes(brands)
  end

  def show
    render json: @brand, serializer: Api::V1::BrandSerializer
  end

  def create
    brand = Brand.create(create_params)
    if brand.new_record?
      render_with_errors brand
    else
      render json: brand, serializer: Api::V1::BrandSerializer
    end
  end

  def update
    if @brand.update_attributes(update_params)
      render json: @brand, serializer: Api::V1::BrandSerializer
    else
      render_with_errors @brand
    end
  end

  def destroy
    if @brand.destroy
      head :ok
    else
      render_with_errors @brand
    end
  end

  private

  def find_brand
    @brand = Brand.find(params[:id])
  end

  def create_params
    params.require(:brand).permit(
      :name
    )
  end

  def update_params
    params.require(:brand).permit(
      :name
    )
  end
end
