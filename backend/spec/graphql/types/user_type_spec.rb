# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::UserType, type: :graphql do
  subject(:result) { executed_query.dig('data', 'node', field) }

  let(:executed_query) { execute_query(query, variables) }
  let(:user) { create(:user) }
  let(:variables) { { id: graphql_id(user) } }

  let(:query) do
    <<-GRAPHQL
    query($id: ID!){
      node(id: $id) {
        ... on User {
          createdAt
          updatedAt
          email
          firstName
          lastName
          birthdate
          about
        }
      }
    }
    GRAPHQL
  end

  describe '#createdAt' do
    let(:field) { 'createdAt' }

    it { is_expected.to eq user.created_at.iso8601 }
  end

  describe '#updatedAt' do
    let(:field) { 'updatedAt' }

    it { is_expected.to eq user.updated_at.iso8601 }
  end

  describe '#email' do
    let(:field) { 'email' }

    it { is_expected.to eq user.email }
  end

  describe '#firstName' do
    let(:field) { 'firstName' }

    it { is_expected.to eq user.first_name }
  end

  describe '#lastName' do
    let(:field) { 'lastName' }

    it { is_expected.to eq user.last_name }
  end

  describe '#birthdate' do
    let(:user) { create(:user, birthdate: '2021-07-03') }
    let(:field) { 'birthdate' }

    it { is_expected.to eq user.birthdate.iso8601 }
  end

  describe '#about' do
    let(:user) { create(:user, about: 'About text') }
    let(:field) { 'about' }

    it { is_expected.to eq user.about }
  end
end
