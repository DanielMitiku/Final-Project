# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :body, presence: true
end
