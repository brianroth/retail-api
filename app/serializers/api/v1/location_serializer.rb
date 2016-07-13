class Api::V1::LocationSerializer < Api::V1::BaseSerializer
  attributes :id, :external_id, :name, :address1, :address2, :city, :state, :postal_code, :created_at, :updated_at
end
