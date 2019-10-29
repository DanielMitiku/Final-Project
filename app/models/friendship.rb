class Friendship < ApplicationRecord
    belongs_to :requestor, class_name: "User", foreign_key: "requestor_id"
    belongs_to :requestee, class_name: "User", foreign_key: "requestee_id"
    validates :requestee_id, presence: true
    validates :requestor_id, presence: true
end
