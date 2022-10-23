# frozen_string_literal: true

Rails.application.routes.draw do
  resource :session
  resources :users, only: %i[create new show]

  root 'users#new'
end
