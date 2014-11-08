class UsersController < ApplicationController

  before_action :check_token_and_ip, except: :authenticate
  
  def authenticate
    user = User.where(code: params[:user_id]).first
    render nothing: true, status: :unauthorized and return if user.nil?
    user.generate_token
    user.ip_address = request.remote_ip
    user.save
    render json: user
  end

  private

  def check_token_and_ip
    @user = User.where(code: params[:user_id], authentication_token: params[:token]).first
    if @user.nil? || @user.ip_address != request.remote_ip
      render nothing: true, status: :unauthorized and return
    end
  end

end