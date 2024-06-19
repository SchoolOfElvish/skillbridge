# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Users::Update do
  subject(:result) { described_class.new.call(user:, attributes:) }

  let(:user) do
    create(:user, first_name: 'Old first name', last_name: 'Old last name')
  end

  let(:attributes) { { first_name: 'New first name', last_name: 'New last name' } }

  context 'when user cannot be saved with provided attributes' do
    before do
      allow(user).to receive(:save).and_return(false)
    end

    it { is_expected.to be_failure }

    it 'returns :user_cannot_be_saved error' do
      expect(result.failure).to eq(:user_cannot_be_saved)
    end
  end

  context 'when user can be saved with provided attributes' do
    let(:updated_user) { result.value! }

    it { is_expected.to be_success }

    it 'updates user first name with provided value' do
      expect(updated_user.first_name).to eq(attributes[:first_name])
    end

    it 'updates user last name with provided value' do
      expect(updated_user.last_name).to eq(attributes[:last_name])
    end

    it 'updates user birthdate with provided value' do
      expect(updated_user.birthdate).to eq(attributes[:birthdate])
    end

    it 'updates user about with provided value' do
      expect(updated_user.about).to eq(attributes[:about])
    end
  end
end
