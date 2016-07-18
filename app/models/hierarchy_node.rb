class HierarchyNode < ApplicationRecord
  has_ancestry
  
  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  has_many :items

  before_destroy :validate_item_presence

  private
  def validate_item_presence
    if items.count > 0
      errors.add(:base, "Cannot delete hierarchy node associated with items")
      throw(:abort)
    end
  end
end
