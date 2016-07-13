class Api::V1::LocationsController < Api::V1::BaseController
  include ActiveHashRelation
  
  before_action :find_location, only: [:show, :update, :destroy]

  def index
    locations = apply_filters(Location.all, filter_params)
    locations = paginate(locations)
    render json: locations,
      each_serializer: Api::V1::LocationSerializer,
      meta: meta_attributes(locations)
  end

  def show
    render json: @location, serializer: Api::V1::LocationSerializer
  end

  def create
    location = Location.create(create_params)
    if location.new_record?
      render_with_errors location
    else
      render json: location, serializer: Api::V1::LocationSerializer
    end
  end

  def update
    if @location.update_attributes(update_params)
      render json: @location, serializer: Api::V1::LocationSerializer
    else
      render_with_errors @location
    end
  end

  def destroy
    if @location.destroy
      head :ok
    else
      render_with_errors @location
    end
  end

  private

  def find_location
    @location = Location.find(params[:id])
  end

  def create_params
    params.require(:location).permit(
      :external_id, :name, :address1, :address2, :city, :state, :postal_code
    )
  end

  def update_params
    params.require(:location).permit(
      :name, :address1, :address2, :city, :state, :postal_code
    )
  end
end
