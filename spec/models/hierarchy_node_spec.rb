require 'rails_helper'
require 'shared_examples_for_models'

describe HierarchyNode do
  describe '#save' do
    subject do
      node = HierarchyNode.new(external_id: 96962, name: 'Coconut Oil Topical')
      node.save
      node.reload
    end

    it { is_expected.to have_attributes name: 'Coconut Oil Topical' }
    it { is_expected.to have_attributes external_id: 96962 }
    it_behaves_like 'a newly created model instance'
  end

  describe '#errors' do
    subject do
      node.validate
      node.errors
    end

    context 'when validation passes' do
      let(:node) { HierarchyNode.new(external_id: 96962, name: 'Coconut Oil Topical') }
      it { should be_empty }
    end

    context 'when validation fails' do
      subject { node }

      context 'when external_id is missing' do
        let(:node) { HierarchyNode.new(name: 'Coconut Oil Topical') }
        it_behaves_like 'an instance with a validation error', :external_id, 'errors.messages.blank'
      end

      context 'when name is missing' do
        let(:node) { HierarchyNode.new(external_id: 96962) }
        it_behaves_like 'an instance with a validation error', :name, 'errors.messages.blank'
      end

      context 'when external_id is a duplicate' do
        subject { HierarchyNode.new(external_id: 96962, name: 'Coconut Oil Topical') }
        before { HierarchyNode.create(external_id: 96962, name: 'Coconut Oil Topical') }
        it_behaves_like 'an instance with a validation error', :external_id, 'errors.messages.taken'
      end
    end
  end
end
