require 'rails_helper'

describe Api::V1::UserSerializer do
  before(:each) do
    @user = FactoryGirl.create(:user, password: 'password')
    @serializer = Api::V1::UserSerializer.new(@user)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  subject { JSON.parse(@serialization.to_json) }

  it 'should include id' do
    expect(subject['user']['id']).to eql(@user.id)
  end

  it 'should include name' do
    expect(subject['user']['name']).to eql(@user.name)
  end

  it 'should include email' do
    expect(subject['user']['email']).to eql(@user.email)
  end

  it 'should include created_at' do
    expect(subject['user']['created_at']).not_to be_nil
  end

  it 'should include updated_at' do
    expect(subject['user']['updated_at']).not_to be_nil
  end
end
