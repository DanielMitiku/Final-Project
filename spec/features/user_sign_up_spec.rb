require 'rails_helper'
require 'spec_helper'

feature 'user signs up' do
    scenario 'with valid parameters' do
        sign_up_with("test", "test", "male", "10/2/2014", "dani@one.com", 'password', 'password')
        expect(page).to have_content('Log out')
    end

    scenario 'with invalid parameters' do
        sign_up_with("test", "test", "male", "10/2/2014", "wrongemail", 'password', 'password')
        expect(page).to have_content('Sign up')
    end

    def sign_up_with(first_name, last_name, gender, birthdate, email, password, password_confirmation)
        visit new_user_registration_path
        fill_in "user_first_name", with: first_name
        fill_in "user_last_name",	with: last_name 
        choose gender
        fill_in "user_birthdate",	with: birthdate
        fill_in "user_email",	with: email
        fill_in "user_password",	with: password
        fill_in "user_password_confirmation", with: password_confirmation
        click_button 'Sign up'
    end
end  

