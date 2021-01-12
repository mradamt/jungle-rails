require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do

    before :each do
      @category = Category.create! name: 'categorio'
    end

    describe "Valid new product" do
      before do
        @product = Product.create name: 'producto', price: 100, quantity: 5, category_id: @category.id
      end
      
      it "saves successfully" do
        expect(Product.last).to eq(@product)
      end
    end

    describe "Invalid new product" do
      
      context "missing name" do
        before do
          @product = Product.create name: nil, price: 100, quantity: 5, category_id: @category.id
        end
        
        it "raises error 'Name can't be blank'" do
          expect(@product.errors.full_messages).to include("Name can't be blank")
        end
      end

      context "missing price" do
        before do
          @product = Product.create name: 'producto', price: nil, quantity: 5, category_id: @category.id
        end
        
        it "raises error 'Price can't be blank'" do
          expect(@product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
        end
      end

      context "missing quantity" do
        before do
          @product = Product.create name: 'producto', price: 100, quantity: nil, category_id: @category.id
        end
        
        it "raises error 'Quantity can't be blank'" do
          expect(@product.errors.full_messages).to include("Quantity can't be blank")
        end
      end

      context "missing category" do
        before do
          @product = Product.create name: 'producto', price: 100, quantity: 5, category_id: nil
        end
        
        it "raises error 'Category can't be blank'" do
          expect(@product.errors.full_messages).to include("Category can't be blank")
        end
      end
    end
  end
end
