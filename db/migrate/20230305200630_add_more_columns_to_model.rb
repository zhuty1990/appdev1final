class AddMoreColumnsToModel < ActiveRecord::Migration[6.0]
  def change
    add_column :artworks, :copyright_notice, :string
    add_column :artworks, :aic_id, :string
    
  end
end
