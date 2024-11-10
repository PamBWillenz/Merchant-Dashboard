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
merchant1 = Merchant.create!(name: "Merchant One")
merchant2 = Merchant.create!(name: "Merchant Two")

# Create customer returns for merchant1
customer_return1 = CustomerReturn.create!(
  order_date: 30.days.ago,
  registered_date: 15.days.ago,
  status: "pending",
  merchant: merchant1
)

customer_return2 = CustomerReturn.create!(
  order_date: 17.days.ago,
  registered_date: 5.days.ago,
  status: "approved",
  merchant: merchant1
)

# Create items for customer_return1
Item.create!(name: "Jacket", price: 10.0, customer_return: customer_return1)
Item.create!(name: "Shoes", price: 20.0, customer_return: customer_return1)

# Create items for customer_return2
Item.create!(name: "Belts", price: 30.0, customer_return: customer_return2)
Item.create!(name: "Pants", price: 40.0, customer_return: customer_return2)

# Create customer returns for merchant2
customer_return3 = CustomerReturn.create!(
  order_date: 25.days.ago,
  registered_date: 15.days.ago,
  status: "rejected",
  merchant: merchant2
)

# Create items for customer_return3
Item.create!(name: "Scarves", price: 50.0, customer_return: customer_return3)
Item.create!(name: "Hats", price: 60.0, customer_return: customer_return3)

puts "Seed data created successfully!"
