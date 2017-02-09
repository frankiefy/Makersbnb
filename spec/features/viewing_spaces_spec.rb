feature 'user can create a space' do
  scenario 'as a logged in user' do
    signup
    login
    name = 'Flat 1'
    create_space(name: name)
    click_button 'view space'
    expect(page).to have_content(name)
    # are we testing that the space has been showed really?
  end
end
