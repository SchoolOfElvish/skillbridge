# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Users::SignIn do
  subject(:sign_in) { service.call(email:, password:) }

  let(:service) { described_class.new(issuer:) }

  let(:issuer) { ->(*) { Success(['token', refresh_token]) } }
  let(:refresh_token) { instance_double(RefreshToken, token: 'RefreshToken') }

  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:password) { user.password }

  context 'when password and email are valid' do
    it 'return success result' do
      expect(sign_in).to be_success
    end
  end

  context 'when email is not valid' do
    let(:email) { user.email.chop }

    it { is_expected.to be_failure }

    it 'return Failure(:user_not_found)' do
      expect(sign_in.failure).to eq(:user_not_found)
    end
  end

  context 'when password is not valid' do
    let(:password) { user.password.chop }

    it { is_expected.to be_failure }

    it 'return Failure(:wrong_password)' do
      expect(sign_in.failure).to eq(:wrong_password)
    end
  end
end
