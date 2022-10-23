# frozen_string_literal: true

class UsersController < ApplicationController
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
      redirect_to user_url(user.id), notice: 'Registration success!'
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
