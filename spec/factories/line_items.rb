FactoryBot.define do
  factory :line_item do
    association :cart
    association :product
  end
end
