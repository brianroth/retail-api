require 'rails_helper'
require 'shared_examples_for_models'

describe Brand do
  describe '#save' do
    subject do
      brand = Brand.new(name: 'General Mills')
      brand.save
      brand.reload
    end

    it { is_expected.to have_attributes name: 'General Mills' }
    it_behaves_like 'a newly created model instance'
  end

  describe '#errors' do
    subject do
      brand.validate
      brand.errors
    end

    context 'when validation passes' do
      let(:brand) { Brand.new(name: 'General Mills') }

      it { should be_empty }
    end

    context 'when validation fails' do
      subject { brand }

      context 'when name is missing' do
        let(:brand) { Brand.new }
        it_behaves_like 'an instance with a validation error', :name, 'errors.messages.blank'
      end

      context 'when name is a duplicate' do
        subject { Brand.new(name: 'General Mills') }
        before { Brand.create(name: 'General Mills') }
        it_behaves_like 'an instance with a validation error', :name, 'errors.messages.taken'
      end
    end
  end
end
