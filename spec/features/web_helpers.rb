def signup(email: 'test@example.com', password_confirmation: 'secret')
  visit('/user/new')
  fill_in 'email', with: email
  fill_in 'password', with: 'secret'
  fill_in 'password_confirmation', with: password_confirmation
  click_button 'Sign Up'
end

def login(email: 'test@example.com', password_confirmation: 'secret')
  visit('/user/login')
  fill_in 'email', with: email
  fill_in 'password', with: 'secret'
  click_button 'Log In'
end
