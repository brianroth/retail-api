FactoryGirl.define do
  factory :user do
    sequence(:name, 100) { |n| "User #{n}" }
    sequence(:email, 100) { |n| "user#{n}@example.com" }
    active { true }
  end
  factory :brand do
    sequence(:name, 100) { |n| "Brand #{n}" }
  end
  factory :item do
    sequence(:upc, 100000)
    sequence(:name, 100000) { |n| "Item #{n}" }
    brand { create :brand }
    uom { 'EA' }
  end
  factory :location do
    sequence(:external_id, 100000)
    sequence(:name, 100000) { |n| "Location #{n}" }
  end
end
