require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "#authenticate" do 
    
    before do 
      @user = User.create code: "foo"
    end

    context 'when the user exists' do 
      before do
        post :authenticate, user_id: 'foo'
      end
      it 'returns the JSON object representing the user' do 
        expect(response.body).to eql(@user.reload.to_json)
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
end
