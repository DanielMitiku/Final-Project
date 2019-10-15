require 'rails_helper'

RSpec.describe Post, type: :model do
    user = User.create(first_name: "dani", last_name: "wesego", gender: "male", birthdate: DateTime.now, email: "dani@web.com", password: "12345678", password_confirmation: "12345678")
    subject {
        described_class.new(title: "post_title", body: "Lorem ipsum", user_id: user.id)
      }

    describe "Associations" do
        it { belong_to(:user) }
    end

    describe "validations" do  
        it "is valid with valid attributes" do
            expect(subject).to be_valid 
        end
        it "is not valid without a title" do
            subject.title = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without a body" do
            subject.body = nil
            expect(subject).to_not be_valid
        end
    end
end