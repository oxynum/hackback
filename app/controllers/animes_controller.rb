class AnimesController < ApplicationController
  def index
    render json: Media.limit_entries(Media.animes)
  end
end