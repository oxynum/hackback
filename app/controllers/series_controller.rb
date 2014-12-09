class SeriesController < ApplicationController

  before_action :check_token_and_ip

  def index
    @series = Media.series
    if params[:page]
      render json: Kaminari.paginate_array(Media.series).page(params[:page]).per(60)
    else
      render json: @series
    end
  end
  def updated_at
    render json: Media.series_json['updated']['$t']
  end
end