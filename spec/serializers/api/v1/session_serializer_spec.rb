require 'rails_helper'

describe Api::V1::SessionSerializer do
  before(:each) do
    @user = FactoryGirl.create(:user, password: 'password')
    @serializer = Api::V1::SessionSerializer.new(@user)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  subject { JSON.parse(@serialization.to_json) }

  it 'should include name' do
    expect(subject['user']['name']).to eql(@user.name)
  end

  it 'should include email' do
    expect(subject['user']['email']).to eql(@user.email)
  end

 it 'should include token' do
    expect(subject['user']['token']).not_to be_nil
  end
end
