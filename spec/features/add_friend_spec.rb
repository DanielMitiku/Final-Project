require 'rails_helper'
require 'spec_helper'


feature 'user adds friend' do
    before do 
        @user1 = User.create(first_name: "dani", last_name: "test", gender: "male", birthdate: DateTime.now, email: "dani@testweb.com", password: "12345678", password_confirmation: "12345678")
        @user2 = User.create(first_name: "daniel", last_name: "dani", gender: "male", birthdate: DateTime.now, email: "dani@daniel.com", password: "12345678", password_confirmation: "12345678")
    end

    scenario 'sending friend request' do
        send_friend_request
        expect(page).to have_content("Friend Request Sent")
        expect(page).to have_button('Cancel Friend Request')
        expect(@user1.pending_friends.last).to eq(@user2)
    end

    def send_friend_request
        sign_in_with("dani@testweb.com","12345678")
        visit users_path
        click_button 'Add Friend'
    end

    def sign_in_with(email, password)
        visit new_user_session_path
        fill_in "user_email",	with: email
        fill_in "user_password",	with: password
        click_button 'Log in'
    end
end  

