require 'rails_helper'

RSpec.describe User, :type => :model do
    let(:user) {User.create(first_name: "dani", last_name: "wesego", gender: "male", birthdate: DateTime.now, email: "dani@webspr.com", password: "12345678", password_confirmation: "12345678")}
      
    describe "Validations" do  
        it "is valid with valid attributes" do
        expect(user).to be_valid 
        end
        it "is not valid without a first_name" do
            user.first_name = nil
            expect(user).to_not be_valid
        end
        it "is not valid without a last_name" do
            user.last_name = nil
            expect(user).to_not be_valid
        end
        it "is not valid without a password" do
            user.password = nil
            expect(user).to_not be_valid
        end
        it "is not valid without a birthdate" do
            user.birthdate = nil
            expect(user).to_not be_valid
        end
        it "is not valid without a gender" do
            user.gender = nil
            expect(user).to_not be_valid
        end
    end

    describe "Associations" do
        it { have_many(:posts) }
    end

end