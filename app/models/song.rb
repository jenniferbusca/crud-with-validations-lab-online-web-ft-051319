# class Song < ActiveRecord::Base
#   validates :title, presence: true
#   validates :title, uniqueness: {
#   scope: %i[release_year artist_name],
#   message: 'cannot be repeated by the same artist in the same year'
#   }
#   validates :released, inclusion: { in: [true, false] }
#   validates :artist_name, presence: true
#
#   with_options if: :released? do |song|
#     song.validates :release_year, presence: true
#     song.validates :release_year, numericality: {
#       less_than_or_equal_to: Date.today.year
#     }
#     end
#
#   def released?
#     released
#   end
# end


class Song < ApplicationRecord
  validates_presence_of :title, :artist_name
  validates :released, inclusion: { in: [true, false] }
  validate :release_year_valid?
  validates :title, uniqueness: {
    scope: %i[release_year artist_name],
    message: 'cannot be repeated by the same artist in the same year'
  }

  def release_year_valid?
    unless released == false
      if release_year.blank?
        errors.add(:release_year, "release year must not be blank")
      elsif release_year > Time.current.year
        errors.add(:release_year, "release year must be less than or equal to current year")
      end
    end
  end

end
