# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_current_user!, except: %i[create new]
  before_action :authorize, except: %i[create new]

  def show
    user = User.find_by(id: params[:id])
    render :show, locals: { user: }
  end

  def new
    render :new, locals: { user: User.new }
  end

  def create
    user = User.new(user_params)
    if user.save
      login!(user)
      redirect_to user_url(user.id), notice: 'Registration success!'
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def authorize
    render json: 'What are you doing here?'.to_json, status: :forbidden if params[:id] != current_user.id.to_s
  end
end
