FactoryBot.define do
  factory :user_registry do
    organization_id { organization }
    user_email { "MyString" }
    is_default { false }
  end
end
