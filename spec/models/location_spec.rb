require 'rails_helper'
require 'shared_examples_for_models'

describe Location do
  describe '#save' do
    subject do
      location = Location.new(external_id: 278,
                              name: "Milford",
                              address1: "1650 Boston Post Road",
                              address2: 'Suite #300',
                              city: "Milford",
                              state: "CT",
                              postal_code: 6461)
      location.save
      location.reload
    end

    it { is_expected.to have_attributes external_id: 278 }
    it { is_expected.to have_attributes name: 'Milford' }
    it { is_expected.to have_attributes address1: '1650 Boston Post Road' }
    it { is_expected.to have_attributes address2: 'Suite #300' }
    it { is_expected.to have_attributes city: 'Milford' }
    it { is_expected.to have_attributes state: 'CT' }
    it { is_expected.to have_attributes postal_code: 6461 }
    it_behaves_like 'a newly created model instance'
  end

  describe '#errors' do
    subject do
      location.validate
      location.errors
    end

    context 'when validation passes' do
      let(:location) { Location.new(external_id: 278, name: 'Milford') }

      it { should be_empty }
    end

    context 'when validation fails' do
      subject { location }

      context 'when name is missing' do
        let(:location) { Location.new(external_id: 278) }
        it_behaves_like 'an instance with a validation error', :name, 'errors.messages.blank'
      end

      context 'when external_id is missing' do
        let(:location) { Location.new(name: 'Milford') }
        it_behaves_like 'an instance with a validation error', :external_id, 'errors.messages.blank'
      end

      context 'when external_id is a duplicate' do
        subject { Location.new(external_id: 278, name: 'Milford') }
        before { Location.create(external_id: 278, name: 'Milford') }
        it_behaves_like 'an instance with a validation error', :external_id, 'errors.messages.taken'
      end
    end
  end
end
