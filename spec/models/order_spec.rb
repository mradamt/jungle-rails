require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category = Category.create! name: 'categorio'
      @product1 = Product.create! name: 'producto', price: 100, quantity: 10, category_id: @category.id
      @product2 = Product.create! name: 'otraproducto', price: 50, quantity: 5, category_id: @category.id
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create! name: 'noproducto', price: 25, quantity: 2, category_id: @category.id
    end
    
    it 'deducts quantity from products based on their line item quantities' do
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(email: 'test@test.com', total_cents: 100, stripe_charge_id: 'test')
      # 2. build line items on @order
      # [@product1, @product2].each do |entry|
      #   quantity = entry[:quantity]
      #   price = entry[:price_cents] / 100
      #   @order.line_items.new(
      #     product: entry,
      #     quantity: 5,
      #     item_price: price,
      #     total_price: price * quantity
      #   )
      # end
      @order.line_items.new(product: @product1, quantity: 5, item_price: 1, total_price: 1)
      @order.line_items.new(product: @product2, quantity: 5, item_price: 1, total_price: 1)
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1[:quantity]).to eq(5)   # -1
      expect(@product2[:quantity]).to eq(0)   # -1
      expect(@product3[:quantity]).to eq(2)   # unchanged
    end
    
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      # byebug
    end
  end
end
