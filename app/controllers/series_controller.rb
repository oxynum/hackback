class SeriesController < ApplicationController

  before_action :check_token_and_ip

  def index
    render json: Kaminari.paginate_array(Media.series).page(params[:page]).per(60)
  end
end