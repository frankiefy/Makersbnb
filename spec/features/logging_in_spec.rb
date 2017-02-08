require 'spec_helper'

feature 'user log in' do
  scenario 'logging in user' do
    email = 'test@example.com'
    signup(email: email)
    login(email: email)
    expect(page).to have_current_path('/space/list') # this is temporarily, it probably can be directed to /
    expect(page).to have_content(email)
  end
end
