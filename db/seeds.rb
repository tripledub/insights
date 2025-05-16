# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create 100 products with random data
puts "Creating 100 products..."

100.times do |i|
  product = Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 5.0..500.0),
    stock_count: Faker::Number.between(from: 10, to: 100)
  )
  puts "Created product #{i+1}: #{product.name}"
end

puts "Seed completed successfully!"
