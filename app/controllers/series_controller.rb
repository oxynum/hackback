class SeriesController < ApplicationController

  before_action :check_token_and_ip

  def index
    render json: Media.series
  end
end