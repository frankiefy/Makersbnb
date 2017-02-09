feature 'user can create a space' do
  scenario 'as a logged in user' do
    signup
    login
    name = 'Flat 1'
    price = '100'
    create_space(name: name, price: price)
    click_button 'view space'
    expect(page.text).to match(/#{name}.*#{price}/)
  end
end
