class CreateBookmarklists < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarklists do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bookmarklists , [:user_id , :created_at]
  end
end
