# Console helper methods for testing Orders and Products
# Load in console with: load 'lib/tasks/console_helpers.rb'

# Create a new order with random products
def create_test_order(product_count: 3)
  # Get random products
  products = Product.order("RANDOM()").limit(product_count)

  # Create a new order
  order = Order.create

  # Add products to the order
  products.each do |product|
    quantity = rand(1..3)
    order_product = OrderProduct.new(
      order: order,
      product: product,
      quantity: quantity
    )
    # Explicitly set the price from the product
    order_product.price_at_order = product.price
    order_product.save!
    # Ensure the order product is saved and associated with the order
    order.order_products.reload
  end

  # Calculate and update total amount
  total = order.order_products.sum { |op| op.price_at_order * op.quantity }
  order.update(total_amount: total)

  puts "Created order ##{order.id} with #{product_count} products, total: $#{order.total_amount}"
  order
end

# Complete an order
def complete_order(order)
  previous_status = order.status
  order.complete!

  puts "Order ##{order.id} changed from #{previous_status} to #{order.status}"
  puts "Updated product counts for all items in the order"
  order
end

# Show order details
def order_details(order)
  puts "Order ##{order.id}"
  puts "Status: #{order.status}"
  puts "Total amount: $#{order.total_amount}"
  puts "Products:"

  order.order_products.includes(:product).each do |op|
    puts "  - #{op.product.name} (#{op.quantity} x $#{op.price_at_order}) = $#{op.quantity * op.price_at_order}"
  end

  nil
end

# Show product details
def product_details(product)
  puts "Product: #{product.name}"
  puts "Price: $#{product.price} (#{(product.price * 100).to_i} cents)"
  puts "Stock count: #{product.stock_count}"
  puts "Pending purchases: #{product.pending_purchase_count}"
  puts "Completed purchases: #{product.purchase_count}"
  puts "Available stock: #{product.available_stock}"

  nil
end

# Convert cents to dollars for display
def cents_to_dollars(cents)
  (cents.to_f / 100).round(2)
end

# Convert dollars to cents for storage
def dollars_to_cents(dollars)
  (dollars.to_f * 100).round
end

puts "Console helpers loaded!"
puts "Available methods:"
puts "  - create_test_order(product_count: 3)"
puts "  - complete_order(order)"
puts "  - order_details(order)"
puts "  - product_details(product)"
