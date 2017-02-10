require 'spec_helper'

feature 'user log out' do
  scenario 'logging out user' do
    email = 'test@example.com'
    signup(email: email)
    login(email: email)
    logout
    expect(page).to have_content("Goodbye " + email)
    expect(page).to have_current_path('/user/login') # this is temporarily, it probably can be directed to /

  end
end
