describe UsersController, type: :controller do 
  describe "#authenticate" do 
    
    before do 
      @user = User.create code: "foo"
    end

    it 'return the JSON object representing the user' do 
      post :authenticate, user_id: 'foo'
      expect(response)
    end
  end

end