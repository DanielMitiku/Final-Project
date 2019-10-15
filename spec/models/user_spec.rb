require 'rails_helper'

RSpec.describe User, :type => :model do
    subject {
        described_class.new(first_name: "dani", last_name: "wesego", gender: "male", birthdate: DateTime.now, email: "dani@web.com", password: "12345678", password_confirmation: "12345678")
      }
      
    describe "Validations" do  
        it "is valid with valid attributes" do
        expect(subject).to be_valid 
        end
        it "is not valid without a first_name" do
            subject.first_name = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without a last_name" do
            subject.last_name = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without a password" do
            subject.password = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without a birthdate" do
            subject.birthdate = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without a gender" do
            subject.gender = nil
            expect(subject).to_not be_valid
        end
    end

    describe "Associations" do
        it { have_many(:posts) }
    end

end