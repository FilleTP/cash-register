Product.destroy_all

strawberries = Product.create!(product_code: "SR1", name: "Strawberries", price: 5.0)
puts "Created #{strawberries.name}"

green_tea = Product.create!(product_code: "GR1", name: "Green Tea", price: 3.11)
puts "Created #{green_tea.name}"

coffee = Product.create!(product_code: "CF1", name: "Coffee", price: 11.23)
puts "Created #{coffee.name}"

puts "Created all #{Product.count} products"
