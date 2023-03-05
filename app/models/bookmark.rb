# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artwork_id :integer
#  user_id    :integer
#
class Bookmark < ApplicationRecord
  belongs_to(:artwork, {
    :class_name => "Artwork",
    :foreign_key => "artwork_id"
  })

end
