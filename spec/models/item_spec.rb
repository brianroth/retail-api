require 'rails_helper'
require 'shared_examples_for_models'

describe Item do
  let(:brand) { FactoryGirl.create :brand }
  let(:hierarchy_node) { FactoryGirl.create :hierarchy_node }
  describe '#save' do
    subject do
      item = Item.create!(name: 'Shave Cream', upc: 87863900122, uom: 'OZ', brand: brand, hierarchy_node: hierarchy_node)
      item.reload
    end

    it { is_expected.to have_attributes name: 'Shave Cream' }
    it { is_expected.to have_attributes uom: 'OZ' }
    it { is_expected.to have_attributes upc: 87863900122 }
    it { is_expected.to have_attributes brand: brand }
    it { is_expected.to have_attributes hierarchy_node: hierarchy_node }
    it_behaves_like 'a newly created model instance'
  end

  describe '#errors' do
    subject do
      item.validate
      item.errors
    end

    context 'when validation passes' do
      let(:item) { Item.new(name: 'Shave Cream', upc: 87863900122, uom: 'OZ', brand: brand, hierarchy_node: hierarchy_node) }
      it { should be_empty }
    end

    context 'when validation fails' do
      subject { item }

      context 'when name is missing' do
        let(:item) { Item.new(upc: 87863900122, uom: 'OZ', brand: brand, hierarchy_node: hierarchy_node) }
        it_behaves_like 'an instance with a validation error', :name, 'errors.messages.blank'
      end

      context 'when upc is missing' do
        let(:item) { Item.new(name: 'Shave Cream', uom: 'OZ', brand: brand, hierarchy_node: hierarchy_node) }
        it_behaves_like 'an instance with a validation error', :upc, 'errors.messages.blank'
      end

      context 'when uom is missing' do
        let(:item) { Item.new(name: 'Shave Cream', upc: 87863900122, brand: brand, hierarchy_node: hierarchy_node) }
        it_behaves_like 'an instance with a validation error', :uom, 'errors.messages.blank'
      end

      context 'when brand is missing' do
        let(:item) { Item.new(name: 'Shave Cream', upc: 87863900122, uom: 'OZ', hierarchy_node: hierarchy_node) }
        it_behaves_like 'an instance with a validation error', :brand, 'errors.messages.blank'
      end

      context 'when hierarchy_node is missing' do
        let(:item) { Item.new(name: 'Shave Cream', upc: 87863900122, uom: 'OZ', brand: brand) }
        it_behaves_like 'an instance with a validation error', :hierarchy_node, 'errors.messages.blank'
      end

      context 'when upc is a duplicate' do
        subject { Item.new(name: 'Shave Cream', upc: 87863900122, uom: 'OZ', brand: brand, hierarchy_node: hierarchy_node) }
        before { Item.create(name: 'Shave Cream', upc: 87863900122, uom: 'OZ', brand: brand, hierarchy_node: hierarchy_node) }
        it_behaves_like 'an instance with a validation error', :upc, 'errors.messages.taken'
      end
    end
  end
end
