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
    friends_array = initiated_friendships.map { |friendship| friendship.requestee if friendship.status }
    friends_array + invited_friendships.map { |friendship| friendship.requestor if friendship.status }
  end

  def pending_friends
    initiated_friendships.map { |friendship| friendship.requestee unless friendship.status }.compact
  end

  def friend_requests
    invited_friendships.map { |friendship| friendship.requestor unless friendship.status }.compact
  end

  def confirm_friend(user)
    friendship = invited_friendships.find { |friendship| friendship.requestor == user }
    friendship.status = true
    friendship.save
  end

  def add_friend(user)
    unless friend?(user)
      add_friendship = Friendship.new(requestee_id: user.id, requestor_id: id)
      if add_friendship.save
        return true
      else
        return false
      end
    end
  end

  def remove_friend(user)
    if friend?(user) || user.friend_requests.include?(self)
      remove_friendship = Friendship.find_by(requestee_id: user.id, requestor_id: id) || Friendship.find_by(requestee_id: id, requestor_id: user.id)
      if remove_friendship.destroy
        return true
      else
        return false
      end
    end
  end

  def friend?(user)
    friends.include?(user)
  end
end
