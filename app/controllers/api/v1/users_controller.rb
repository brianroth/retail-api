class Api::V1::UsersController < Api::V1::BaseController
  include ActiveHashRelation
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    users = apply_filters(User.all, filter_params)
    users = paginate(users)
    render json: users,
      each_serializer: Api::V1::UserSerializer,
      meta: meta_attributes(users)
  end

  def show
    render json: @user, serializer: Api::V1::UserSerializer
  end

  def create
    user = User.create(create_params)
    if user.new_record?
      render_with_errors user
    else
      render json: user, serializer: Api::V1::UserSerializer
    end
  end

  def update
    if @user.update_attributes(update_params)
      render json: @user, serializer: Api::V1::UserSerializer
    else
      render_with_errors @user
    end
  end

  def destroy
    if @user.destroy
      head :ok
    else
      render_with_errors @user
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def create_params
    params.require(:user).permit(
      :email, :name
    )
  end

  def update_params
    params.require(:user).permit(
      :email, :name
    )
  end
end
