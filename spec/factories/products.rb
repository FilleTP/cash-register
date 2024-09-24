FactoryBot.define do
  factory :product do
    name { "Sample Product" }
    price { 10.0 }
    product_code { "PRD123" }

    after(:build) do |product|
      product.photo.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'default-image.webp')),
        filename: 'default_image.webp',
        content_type: 'image/webp')
    end
  end
end
