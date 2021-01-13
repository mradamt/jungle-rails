require 'rails_helper'

RSpec.feature "Existing user navigates to login page and enters their information", type: :feature, js: true do

  # SETUP
  valid_user = {first_name: 'first', last_name: 'last', email: 'test@test.com', password: 'password', password_confirmation: 'password'}
  before do
    @user = User.create! valid_user    
  end

  scenario "They are successfully logged into the app" do
    # ACT
    visit root_path
    click_on 'Login'
    
    fill_in 'session[email]',     with: 'test@test.com'
    fill_in 'session[password]',  with: 'password'
    click_button 'Submit'
    
    # VERIFY
    # check that navbar has switched to logged-in state
    expect(page.find('nav')).to have_no_text 'Login'
    expect(page.find('nav')).to have_text 'Logout'
    # test if redirect has been successful
    expect(page).to have_text 'Products'

  end

end