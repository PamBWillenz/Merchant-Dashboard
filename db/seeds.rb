# db/seeds.rb

# Clearing existing data: The destroy_all method is used to clear existing data to avoid duplication.
# Creating merchants: Two merchants are created.
# Creating customer returns: Customer returns are created for each merchant with different statuses and dates.
# Creating items: Items are created and associated with the respective customer returns.
# Output: A success message is displayed after the seed data is created successfully.

# Clear existing data
Item.destroy_all
CustomerReturn.destroy_all
Merchant.destroy_all

# Create merchants
merchants = []
20.times do |i|
  merchants << Merchant.create!(name: "Merchant #{i + 1}")
end

# Create customer returns and items for each merchant
merchants.each do |merchant|
  3.times do 
    order_date = rand(1..60).days.ago
    registered_date = order_date + rand(5..25).days
    customer_return = CustomerReturn.create!(
      order_date: order_date,
      registered_date: registered_date,
      status: %w[pending approved rejected].sample,
      merchant: merchant
    )

    # Create items for each customer return
    items = [
      { name: "Shirt", price: 25.0 },
      { name: "Pants", price: 40.0 },
      { name: "Jacket", price: 60.0 },
      { name: "Shoes", price: 80.0 },
      { name: "Hat", price: 15.0 },
      { name: "Scarf", price: 20.0 },
      { name: "Gloves", price: 10.0 },
      { name: "Socks", price: 5.0 },
      { name: "Belt", price: 12.0 },
      { name: "Tie", price: 18.0 }
    ]

    items.sample(3).each do |item|
      Item.create!(name: item[:name], price: item[:price], customer_return: customer_return)
    end
  end
end

puts "Seed data created successfully!"
