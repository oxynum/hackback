class AnimesController < ApplicationController
  before_action :check_token_and_ip
  def index
    render json: Kaminari.paginate_array(Media.animes).page(params[:page]).per(60)
  end

  def updated_at
    render json: Media.animes_json['updated']['$t']
  end
end