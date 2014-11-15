class MoviesController < ApplicationController

  before_action :check_token_and_ip

  def index
    render json: Kaminari.paginate_array(Media.movies).page(params[:page]).per(60)
  end
end