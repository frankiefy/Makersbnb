require 'spec_helper'

xfeature 'user can request to book a space' do
  scenario 'as a logged in user' do
    signup
    login
    create_space
    # logout

    # signup(newuser)
    # login(newuser)

    click_button 'Listings'
    # given one space then
      click_button 'view space'
    # choose date
    click_button 'Request Booking'

    expect(page).to have_current_path('/requests')
    expect(page).to have_content(' SPACE_NAME...Not confirmed...DATE')
  end

  scenario 'as a unlogged user' do
    visit '/space/new'
    expect(page).to have_current_path('/user/login')
  end
end
