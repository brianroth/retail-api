require 'rails_helper'

describe Api::V1::LocationSerializer do
  before(:each) do
    @location = FactoryGirl.create(:location)
    @serializer = Api::V1::LocationSerializer.new(@location)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  subject { JSON.parse(@serialization.to_json) }

  it 'should include id' do
    expect(subject['location']['id']).to eql(@location.id)
  end

  it 'should include name' do
    expect(subject['location']['name']).to eql(@location.name)
  end

  it 'should include email' do
    expect(subject['location']['external_id']).to eql(@location.external_id)
  end

  it 'should include created_at' do
    expect(subject['location']['created_at']).not_to be_nil
  end

  it 'should include updated_at' do
    expect(subject['location']['updated_at']).not_to be_nil
  end
end
