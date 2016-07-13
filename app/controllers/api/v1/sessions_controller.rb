class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_user

  def create
    user = User.find_by(email: create_params[:email]).try(:authenticate, create_params[:password])
    if user
      render json: user, serializer: Api::V1::SessionSerializer
    else
      head :unauthorized
    end
  end

  private
  def create_params
    params.require(:user).permit(:email, :password)
  end
end
