class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches, id: :uuid do |t|
      t.string :subject
      t.string :author
      t.string :sort_order

      t.timestamps
    end
  end
end
