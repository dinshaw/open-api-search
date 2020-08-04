class AddUniqueIndexToSearches < ActiveRecord::Migration[6.0]
  def change
    add_index :searches, [:subject, :author, :sort_order], unique: true
  end
end
