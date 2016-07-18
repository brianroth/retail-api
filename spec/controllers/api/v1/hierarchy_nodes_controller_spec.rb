require 'rails_helper'

describe Api::V1::HierarchyNodesController do
  it { should route(:get, '/api/v1/hierarchy_nodes').to(action: :index) }
  it { should route(:get, '/api/v1/hierarchy_nodes/1234').to(action: :show, id: '1234') }
  it { should route(:put, '/api/v1/hierarchy_nodes/1234').to(action: :update, id: '1234') }
  it { should route(:delete, '/api/v1/hierarchy_nodes/1234').to(action: :destroy, id: '1234') }
  it { should route(:post, '/api/v1/hierarchy_nodes').to(action: :create) }
end
