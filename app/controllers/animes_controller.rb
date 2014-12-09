class AnimesController < ApplicationController
  before_action :check_token_and_ip
  def index
    @animes = Media.animes
    if params[:page]
      render json: Kaminari.paginate_array(@animes).page(params[:page]).per(60)
    else
      render json: @animes
    end
  end

  def updated_at
    render json: Media.animes_json['updated']['$t']
  end
end