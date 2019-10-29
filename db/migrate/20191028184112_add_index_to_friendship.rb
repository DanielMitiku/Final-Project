class AddIndexToFriendship < ActiveRecord::Migration[6.0]
  def change
    add_index :friendships, :requestor_id
    add_index :friendships, :requestee_id
    add_index :friendships, [:requestor_id, :requestee_id], unique: true
  end
end
