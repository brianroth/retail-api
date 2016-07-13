class Api::V1::BrandSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :created_at, :updated_at
end