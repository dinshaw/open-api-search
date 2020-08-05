class AddIndexForUsersSearches < ActiveRecord::Migration[6.0]
  def change
    add_index :searches, :user_id
  end
end
