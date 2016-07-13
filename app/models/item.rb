class Item < ApplicationRecord
  validates :upc, presence: true, uniqueness: true
  validates :name, presence: true
  validates :uom, presence: true
  validates :brand, :presence => true

  belongs_to :brand
end
