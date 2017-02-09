feature 'user can create a space' do
  scenario 'as a logged in user' do
    signup
    login
    create_space
    click_button 'view space'
    expect(page).to have_content('request booking')
  end
end
