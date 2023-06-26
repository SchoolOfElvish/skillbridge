# frozen_string_literal: true

FactoryBot.define do
  factory :whitelisted_token do
    jti { 'MyString' }
    user { nil }
    exp { '2023-06-26 21:07:28' }
  end
end
