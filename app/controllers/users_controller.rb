class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid,  with: :render_unprocessable_entity
  before_action      :authorize
  skip_before_action :authorize, only: [:create]

  def create
    user = User.create!(user_params)
    render json: user, status: :created
    session[:user_id] = user.id
  end
  
  def show
    user = find_user
    render json: user, status: :ok
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end

  def find_user
    User.find(session[:user_id])
  end

  def render_not_found
    render json: {error: "User not found"}, status: :not_found
  end

  def render_unprocessable_entity exception
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def authorize
    return render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
  end

end



# if user.valid?
    #   render json: user, status: :created
    # else 
    #   render json: {error: user.errors.full_messages }, status: :unprocessable_entity
    # end