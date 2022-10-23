# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render :new, locals: { user: User.new }
  end

  def create
    user = User.find_by_credentials(
      username: params[:user][:username],
      password: params[:user][:password]
    )

    if user.nil?
      render json: 'Invalid credentials'.to_json, status: :unprocessable_entity
    else
      login!(user)
      redirect_to user_url(user.id), notice: 'Log in success!'
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
