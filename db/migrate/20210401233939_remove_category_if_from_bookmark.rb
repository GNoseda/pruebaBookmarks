class RemoveCategoryIfFromBookmark < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookmarks, :category_id, :bigint
  end
end
