require 'rails_helper'

describe Api::V1::HierarchyNodeSerializer do
  before(:each) do
    @node = FactoryGirl.create(:hierarchy_node)
    @serializer = Api::V1::HierarchyNodeSerializer.new(@node)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  subject { JSON.parse(@serialization.to_json) }

  it 'should include id' do
    expect(subject['hierarchy_node']['id']).to eql(@node.id)
  end

  it 'should include name' do
    expect(subject['hierarchy_node']['name']).to eql(@node.name)
  end

  it 'should include created_at' do
    expect(subject['hierarchy_node']['created_at']).not_to be_nil
  end

  it 'should include updated_at' do
    expect(subject['hierarchy_node']['updated_at']).not_to be_nil
  end
end
