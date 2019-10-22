require 'rails_helper'
require 'spec_helper'


feature 'user create post and likes post' do
    before do 
        @user = User.create(first_name: "dani", last_name: "test", gender: "male", birthdate: DateTime.now, email: "dani@testweb.com", password: "12345678", password_confirmation: "12345678")
    end

    scenario 'with valid parameters' do
        create_and_like_post_with("title1", 'body of title 1')
        expect(page).to have_button('Unlike')
    end

    def create_and_like_post_with(title, body)
        sign_in_with("dani@testweb.com","12345678")
        click_button 'Create Post'
        fill_in "post_title",	with: title
        fill_in "post_body",	with: body
        click_button 'commit'
        click_button 'Like'
    end

    def sign_in_with(email, password)
        visit new_user_session_path
        fill_in "user_email",	with: email
        fill_in "user_password",	with: password
        click_button 'Log in'
    end
end  

