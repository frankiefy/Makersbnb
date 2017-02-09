require 'spec_helper'
require 'pry'

feature 'user can request to book a space' do
  scenario 'as a logged in user' do
    renter = "alfie.shaw@gmail.com"
    signup(email: renter)
    login(email: renter)
    flat_name1 = "hgdfjhgdjhtd"
    create_space(name: flat_name1)
    flat_name2 = "flat12"
    create_space(name: flat_name2)
    logout

    rentee = "franklin.shaw@gmail.com"
    signup(email: rentee)
    login(email: rentee)

    click_button 'Listings'
    find(:xpath, "//*[@id='spaces']/div/div/h2[text()='#{flat_name2}']/../../div/form/input").click
    date = '08/01/2017'
    fill_in 'request_date', with: date
    click_button 'Request Booking'

    expect(page).to have_current_path('/requests')
    expect(page.text).to match(/#{flat_name2}.*Not confirmed.*#{date}/)
  end

  scenario 'as a unlogged user' do
    visit '/space/new'
    expect(page).to have_current_path('/user/login')
  end
end
