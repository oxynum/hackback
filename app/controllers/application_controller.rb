class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  after_filter :set_access_control_headers

  # respond to options requests with blank text/plain as per spec
  def cors_preflight_check
    logger.info ">>> responding to CORS request"
    render :text => '', :content_type => 'text/plain'
  end

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = '*' 
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*' 
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-CSRF-Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  protected

  def check_token_and_ip
    @user = User.where(code: params[:code]||params[:user_id], authentication_token: params[:token]).first
    if @user.nil? || @user.ip_address != request.remote_ip
      render nothing: true, status: :unauthorized and return
    end
  end
end
