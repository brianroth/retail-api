class Item < ApplicationRecord
  validates :upc, presence: true, uniqueness: true
  validates :name, presence: true
  validates :uom, presence: true
  validates :brand, :presence => true
  validates :hierarchy_node, :presence => true

  belongs_to :brand
  belongs_to :hierarchy_node
end
