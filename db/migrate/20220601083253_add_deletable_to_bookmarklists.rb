class AddDeletableToBookmarklists < ActiveRecord::Migration[6.1]
  def change
    add_column :bookmarklists, :deletable, :boolean , default: true
  end
end
