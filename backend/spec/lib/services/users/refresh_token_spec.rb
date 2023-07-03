# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Users::RefreshToken, type: :service do
  subject(:refresh) { service.call(token_params:) }

  let(:service) { described_class.new(decoder:, refresher:) }
  let(:decoder) { instance_double(Services::Jwt::Decoder, decode: decoded_token) }
  let(:refresher) { instance_double(Services::Jwt::Refresher, call: Success([token, refresh_token])) }

  let(:user) { create(:user) }

  let(:token) { 'JWT' }
  let(:refresh_token) { create(:refresh_token, user:) }

  let(:decoded_token) do
    Success({
              user_id: user.id,
              exp: 1.day.from_now.to_i,
              iat: Time.now.to_i
            })
  end

  let(:token_params) do
    {
      token: 'JWT',
      refreshToken: 'TEST'
    }
  end

  context 'when tokens are refreshed' do
    it 'returns success' do
      expect(refresh).to be_success
    end

    it 'returns new access token' do
      expect(refresh.value![0]).to be_a String
    end

    it 'returns new refresh token' do
      expect(refresh.value![1]).to be_a String
    end
  end
end
