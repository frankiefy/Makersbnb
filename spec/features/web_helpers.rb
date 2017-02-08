def signup(email: 'test@example.com', password_confirmation: 'secret')
  visit('/user/new')
  fill_in 'email', with: email
  fill_in 'password', with: 'secret'
  fill_in 'password_confirmation', with: password_confirmation
  click_button 'Sign Up'
end

def login(email: 'test@example.com', password: 'secret')
  visit('/user/login')
  fill_in 'email', with: email
  fill_in 'password', with: password
  click_button 'Log In'
end

def create_space(name: 'Flat 1', description: 'Tiny Flat', price: '50', start_date: '07/01/2017', end_date: '14/01/2017')
  visit '/space/new'
  fill_in 'name', with: name
  fill_in 'description', with: description
  fill_in 'price', with: price
  fill_in 'start_date', with: start_date
  fill_in 'end_date', with: end_date
  click_button 'Create Space'
end
