class Api::V1::HierarchyNodeSerializer < Api::V1::BaseSerializer
  attributes :id, :external_id, :name, :created_at, :updated_at
end