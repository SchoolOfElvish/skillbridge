# frozen_string_literal: true

FactoryBot.define do
  factory :refresh_token do
    crypted_token { 'MyString' }
    user { nil }
  end
end
