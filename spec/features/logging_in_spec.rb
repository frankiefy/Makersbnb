require 'spec_helper'

feature 'user log in' do
  scenario 'logging in user' do
    signup
    login
    expect(page).to have_current_path('/listings')
  end
end
