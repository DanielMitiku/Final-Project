# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :initiated_friendships, class_name: 'Friendship', foreign_key: 'requestor_id'
  has_many :invited_friendships, class_name: 'Friendship', foreign_key: 'requestee_id'

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :birthdate, presence: true

  def friends
    friends_array = initiated_friendships.map { |f| f.requestee if f.status }
    friends_array + invited_friendships.map { |f| f.requestor if f.status }
  end

  def pending_friends
    initiated_friendships.map { |f| f.requestee unless f.status }.compact
  end

  def friend_requests
    invited_friendships.map { |f| f.requestor unless f.status }.compact
  end

  def confirm_friend(user)
    friendship = invited_friendships.find { |f| f.requestor == user }
    friendship.status = true
    friendship.save
  end

  def add_friend(user)
    unless friend?(user)
      add_friendship = Friendship.new(requestee_id: user.id, requestor_id: id)
      return true if add_friendship.save
    end
    false
  end

  def remove_friend(user)
    return unless friend?(user) || user.friend_requests.include?(self)

    remove_friendship = Friendship.find_by(requestee_id: user.id, requestor_id: id) || Friendship.find_by(requestee_id: id, requestor_id: user.id)
    return true if remove_friendship.destroy

    false
  end

  def friend?(user)
    friends.include?(user)
  end
end
