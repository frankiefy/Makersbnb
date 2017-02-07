require 'spec_helper'

describe User do

  describe "#authenticate" do
    let(:user) { User.create(email: 'adalove@gmail.com', password: '123', password_confirmation: '123') }
    
    it 'confirm the user exists when given user_name and password' do
      existing_user = User.authenticate(user.email, user.password)
      expect(existing_user).to eq user
    end

    it 'doesn\'t authenticate unexisting users' do
      existing_user = User.authenticate('blabla123', user.password)
      expect(existing_user).to eq nil
    end

    it 'doesn\'t authenticate mismatching password' do
      existing_user = User.authenticate('adalove@gmail.com', '1234')
      expect(existing_user).to eq nil
    end
  end
end
