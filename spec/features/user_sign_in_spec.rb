require 'rails_helper'
require 'spec_helper'


feature 'user signs in' do
    before do 
        @user = User.create(first_name: "dani", last_name: "test", gender: "male", birthdate: DateTime.now, email: "dani@testweb1.com", password: "12345678", password_confirmation: "12345678")
    end

    scenario 'with valid parameters' do
        sign_in_with("dani@testweb1.com", '12345678')
        expect(page).to have_content('Log out')
    end

    scenario 'with invalid parameters' do
        sign_in_with("dani@testweb1.com", '123456')
        expect(page).to have_content('Log in')
    end

    def sign_in_with(email, password)
        visit new_user_session_path
        fill_in "user_email",	with: email
        fill_in "user_password",	with: password
        click_button 'Log in'
    end
end  

