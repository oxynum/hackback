require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before do 
    @user = User.create code: "foo"
  end

  describe "#authenticate" do 
  
    context 'when the user exists' do 
      before do
        post :authenticate, user_id: 'foo'
      end
      it 'returns the JSON object representing the user' do 
        expect(response.body).to eql(@user.reload.to_json)
      end

      it 'updates the token of the user' do 
        old_token = @user.reload.authentication_token
        post :authenticate, user_id: 'foo'
        expect(old_token).not_to eq(@user.reload.authentication_token)
      end

      it 'updates the ip address of the user' do 
        old_ip = @user.reload.ip_address
        expect(old_ip).not_to be_blank
        @request.env['REMOTE_ADDR'] = '1.2.3.4'
        post :authenticate, user_id: 'foo'
        expect(@user.reload.ip_address).to eq('1.2.3.4')
      end
    end

    context 'when the user does not exist' do 
      before do
        post :authenticate, user_id: 'bar'
      end
      it 'returns an unauthorized status' do 
        expect(response.status).to eq(401)
      end
    end
    
  end

  describe "#check_token_and_ip" do 
    
    before do 
      class UsersController 
        def bar
          render nothing: true
        end
      end
      begin
        _routes = Rails.application.routes
        _routes.disable_clear_and_finalize = true
        _routes.clear!
        Rails.application.routes_reloader.paths.each { |path| load(path) }
        _routes.draw do
            resources :users, only: [] do 
              get 'bar'
            end
        end
        ActiveSupport.on_load(:action_controller) { _routes.finalize! }
      ensure
        _routes.disable_clear_and_finalize = false
      end

      post :authenticate, user_id: @user.code
      @user.reload
    end

    it 'returns unauthorized if the code is unknown' do 
      get :bar, user_id: "eflhwr", token: "oubnj"
      expect(response.status).to eq(401)
    end

    it 'returns unauthorized if the authentication_token is unknown' do 
      get :bar, user_id: @user.code, token: "eklfnef"
      expect(response.status).to eq(401)
    end

    it 'returns unauthorized if the ip address is unknown' do
      @request.env['REMOTE_ADDR'] = '1.2.3.4'
      get :bar, user_id: @user.code, token: @user.authentication_token
      expect(response.status).to eq(401)
    end

    it 'returns a success if the ip address, the code and the authentication_token is known' do 
      get :bar, user_id: @user.code, token: @user.authentication_token
      expect(response.status).to eq(200)
    end

  end
end
