require 'rails_helper'

describe Api::V1::LocationsController do
  it { should route(:get, '/api/v1/locations').to(action: :index) }
  it { should route(:get, '/api/v1/locations/1234').to(action: :show, id: '1234') }
  it { should route(:put, '/api/v1/locations/1234').to(action: :update, id: '1234') }
  it { should route(:delete, '/api/v1/locations/1234').to(action: :destroy, id: '1234') }
  it { should route(:post, '/api/v1/locations').to(action: :create) }
end
