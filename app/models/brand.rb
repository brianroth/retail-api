class Brand < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :items
  before_destroy :validate_item_presence

  private

  def validate_item_presence
    if items.count > 0
      errors.add(:base, "Cannot delete brand associated with items")
      throw(:abort)
    end
  end
end
