class AddColumnstoBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmarks, :aic_id, :string
  end
end
