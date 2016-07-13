require 'rails_helper'

describe Api::V1::BrandSerializer do
  before(:each) do
    @brand = FactoryGirl.create(:brand)
    @serializer = Api::V1::BrandSerializer.new(@brand)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  subject { JSON.parse(@serialization.to_json) }

  it 'should include id' do
    expect(subject['brand']['id']).to eql(@brand.id)
  end

  it 'should include name' do
    expect(subject['brand']['name']).to eql(@brand.name)
  end

  it 'should include created_at' do
    expect(subject['brand']['created_at']).not_to be_nil
  end

  it 'should include updated_at' do
    expect(subject['brand']['updated_at']).not_to be_nil
  end
end
