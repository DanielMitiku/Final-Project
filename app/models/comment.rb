# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, presence: true
  default_scope -> { order(created_at: :desc) }
end
