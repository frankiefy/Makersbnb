require 'spec_helper'

feature 'user can create a space' do
  scenario 'as a logged in user' do
    signup
    login

    name = 'Flat 1'
    description = 'Tiny Flat'
    create_space(description: description)

    expect(page).to have_current_path('/space/list')
    expect(page).to have_content(description)
  end

  scenario 'as a unlogged user' do
    visit '/space/new'
    expect(page).to have_current_path('/user/login')
  end
end
