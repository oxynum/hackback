class AnimesController < ApplicationController
  before_action :check_token_and_ip
  def index
    render json: Media.limit_entries(Media.animes)
  end
end