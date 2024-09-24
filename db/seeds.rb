require "open-uri"

Product.destroy_all

strawberries = Product.new(product_code: "SR1", name: "Strawberries", price: 5.0)
strawberry_file = URI.open("https://res.cloudinary.com/dgkfw5qpt/image/upload/v1727179253/strawberry_cyfxg7.webp")
strawberries.photo.attach(io: strawberry_file, filename: "strawberries.webp", content_type: "image/webp")
strawberries.save!
puts "Created #{strawberries.name}"

green_tea = Product.new(product_code: "GR1", name: "Green Tea", price: 3.11)
green_tea_file = URI.open("https://res.cloudinary.com/dgkfw5qpt/image/upload/v1727179222/green-tea_vdeaz3.webp")
green_tea.photo.attach(io: green_tea_file, filename: "green_tea.webp", content_type: "image/webp")
green_tea.save!
puts "Created #{green_tea.name}"

coffee = Product.new(product_code: "CF1", name: "Coffee", price: 11.23)
coffee_file = URI.open("https://res.cloudinary.com/dgkfw5qpt/image/upload/v1727179247/coffee_hqp8op.webp")
coffee.photo.attach(io: coffee_file, filename: "coffee.webp", content_type: "image/webp")
coffee.save!
puts "Created #{coffee.name}"

puts "Created all #{Product.count} products"
