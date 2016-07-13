require 'rails_helper'
require 'shared_examples_for_models'

describe User do
  describe '#save' do
    subject do
      user = User.new(name: 'Retail User',
                      email: 'user@example.com',
                      active: true,
                      password: 'password')
      user.save
      user.reload
    end

    it { is_expected.to have_attributes name: 'Retail User' }
    it { is_expected.to have_attributes email: 'user@example.com' }
    it { is_expected.to have_attributes active: true }
    it_behaves_like 'a newly created model instance'
  end

  describe '#errors' do
    subject do
      user.validate
      user.errors
    end

    context 'when validation passes' do
      let(:user) { User.new(name: 'Retail User', email: 'user@example.com', active: true, password: 'password') }

      it { should be_empty }
    end

    context 'when validation fails' do
      subject { user }

      context 'when name is missing' do
        let(:user) { User.new(email: 'user@example.com', active: true, password: 'password') }
        it_behaves_like 'an instance with a validation error', :name, 'errors.messages.blank'
      end

      context 'when email is missing' do
        let(:user) { User.new(name: 'Retail User', active: true, password: 'password') }
        it_behaves_like 'an instance with a validation error', :email, 'errors.messages.blank'
      end

      context 'when email is a duplicate' do
        subject { User.new(name: 'Retail User', active: true, email: 'User@example.com') }
        before { User.create(name: 'Retail User', active: true, email: 'user@example.com', password: 'password') }
        it_behaves_like 'an instance with a validation error', :email, 'errors.messages.taken'
      end
    end
  end
end
