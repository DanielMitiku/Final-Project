require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) {User.create(first_name: "dani", last_name: "wesego", gender: "male", birthdate: DateTime.now, email: "dani@webspr.com", password: "12345678", password_confirmation: "12345678")}
  let(:user2) {User.create(first_name: "daniel", last_name: "mitiku", gender: "male", birthdate: DateTime.now, email: "daniel@daniel.com", password: "12345678", password_confirmation: "12345678")}
  subject {
      described_class.new(requestee_id: user1.id, requestor_id: user2.id, status: true)
    }

  describe "Associations" do
      it { belong_to(:requestor) }
      it { belong_to(:requestee) }
  end

  describe "validations" do  
    it "is valid with valid attributes" do
        expect(subject).to be_valid 
    end
    it "is not valid without a requestee_id" do
        subject.requestee_id = nil
        expect(subject).to_not be_valid
    end
  end
end
