# == Schema Information
#
# Table name: artworks
#
#  id               :integer          not null, primary key
#  artist_title     :string
#  copyright_notice :string
#  image            :string
#  medium           :string
#  place_of_origin  :string
#  style            :string
#  title            :string
#  year             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  aic_id           :string
#  medium_id        :string
#  style_id         :string
#
class Artwork < ApplicationRecord
  validates(:aic_id, { :uniqueness => true })
end
