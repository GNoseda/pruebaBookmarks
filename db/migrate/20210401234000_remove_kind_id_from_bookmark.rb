class RemoveKindIdFromBookmark < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookmarks, :kind_id, :bigint
  end
end
