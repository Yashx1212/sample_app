class CreateSavedposts < ActiveRecord::Migration[6.1]
  def change
    create_table :savedposts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bookmarklist, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true

      t.timestamps
    end
    add_index :savedposts, [:user_id , :bookmarklist_id]
  end
end
