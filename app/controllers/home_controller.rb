# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render
  end

  def list
    render json: params
  end
end
