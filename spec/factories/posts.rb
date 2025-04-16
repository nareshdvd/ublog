FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "post #{n}" }
    body { "Testing body" }
    author_id { user.id }
  end
end
