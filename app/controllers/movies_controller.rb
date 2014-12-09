class MoviesController < ApplicationController

  before_action :check_token_and_ip

  def index
    @movies = Media.movies
    if params[:page]
      render json: Kaminari.paginate_array(Media.movies).page(params[:page]).per(60)
    else
      render json: @movies
    end
  end
  def updated_at
    render json: Media.movies_json['updated']['$t']
  end
end