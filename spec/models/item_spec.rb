# spec/models/item_spec.rb
require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:customer_return) }
end