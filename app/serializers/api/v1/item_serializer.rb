class Api::V1::ItemSerializer < Api::V1::BaseSerializer
  attributes :id, :upc, :name, :uom, :brand_id, :created_at, :updated_at
end