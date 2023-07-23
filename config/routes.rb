# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks, only: :index

  root "home#index"
  get "/home/:id/:user" => "home#list"
  get "*path", to: "home#index", via: :all
end
