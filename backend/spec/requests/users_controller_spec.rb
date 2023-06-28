# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersController' do
  let(:email) { 'test@test.ts' }
  let(:password) { '12345678' }
  let(:params) { { email:, password:, password_confirmation: password } }
  let(:parsed_body) { response.parsed_body }

  let(:user) { create(:user) }

  describe 'POST /sign-in' do
    context 'with valid params' do
      it 'finds user' do
        post '/api/sign-in', params: { email: user.email, password: user.password }
        expect(parsed_body).to have_key('token')
      end
    end

    context 'with wrong password' do
      it 'returns error' do
        post '/api/sign-in', params: { email: user.email, password: '87654321' }
        expect(parsed_body['error']).to eq('Wrong password')
      end
    end

    context 'with wrong email' do
      it 'returns error' do
        post '/api/sign-in', params: { email: 'test@test.ts', password: '87654321' }
        expect(parsed_body['error']).to eq('User not found')
      end
    end
  end
end
