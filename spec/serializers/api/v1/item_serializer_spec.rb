require 'rails_helper'

describe Api::V1::ItemSerializer do
  before(:each) do
    @item = FactoryGirl.create(:item)
    @serializer = Api::V1::ItemSerializer.new(@item)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  subject { JSON.parse(@serialization.to_json) }

  it 'should include id' do
    expect(subject['item']['id']).to eql(@item.id)
  end

  it 'should include name' do
    expect(subject['item']['name']).to eql(@item.name)
  end

  it 'should include upc' do
    expect(subject['item']['upc']).to eql(@item.upc)
  end

  it 'should include uom' do
    expect(subject['item']['uom']).to eql(@item.uom)
  end

  it 'should include brand_id' do
    expect(subject['item']['brand_id']).to eql(@item.brand_id)
  end

  it 'should include created_at' do
    expect(subject['item']['created_at']).not_to be_nil
  end

  it 'should include updated_at' do
    expect(subject['item']['updated_at']).not_to be_nil
  end
end
