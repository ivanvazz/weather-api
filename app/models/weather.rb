class Weather < ApplicationRecord
  validates :city, presence: true, case_sensitive: false
  before_save :downcase_fields

  def downcase_fields
    self.city.downcase!
  end
end
