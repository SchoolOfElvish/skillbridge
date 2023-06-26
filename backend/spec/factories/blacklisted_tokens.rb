FactoryBot.define do
  factory :blacklisted_token do
    jti { "MyString" }
    user { nil }
    exp { "2023-06-26 20:59:22" }
  end
end
