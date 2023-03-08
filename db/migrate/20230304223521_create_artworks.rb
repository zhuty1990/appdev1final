class CreateArtworks < ActiveRecord::Migration[6.0]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :artist_title
      t.string :style
      t.string :style_id
      t.string :medium
      t.string :medium_id
      t.string :year
      t.string :place_of_origin
      t.string :image

      t.timestamps
    end
  end
end
