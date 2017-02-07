require 'spec_helper'

feature 'user sign up' do
  scenario 'creating new user' do
    expect { signup }.to change(User, :count).by(1)
    expect(page).to have_current_path('/user/login')
  end


  scenario 'with wrong password confirmation' do
    signup(password_confirmation: 'wrong')
    expect(page).to have_current_path('/user/signing_up')
    expect(page).to have_content('Password and confirmation password do not match')
  end

  scenario 'with blank email' do
    signup(email: '')
    expect(page).to have_current_path('/user/signing_up')
  end

  scenario 'with wrong email' do
    signup(email: 'adssad--sdfcv-//asd-sadasd')
    expect(page).to have_current_path('/user/signing_up')
  end

  scenario '2 times' do
    signup
    signup
    expect(page).to have_current_path('/user/signing_up')
    expect(page).to have_content("We already have that email.")
  end
end
