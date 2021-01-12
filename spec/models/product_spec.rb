require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    describe "Valid new product" do
      before do
        @category = Category.new(name: 'cat')
        @category.save
        @product = Product.new(name: 'producto', price: 100, quantity: 5, category_id: @category.id)
        @product.save
      end
      
      it "saves successfully" do
        expect(Product.last).to eq(@product)
      end
    end

    describe "Invalid new product" do
      
      context "no name" do
        before do
          @category = Category.new(name: 'cat')
          @category.save
          @product = Product.new(name: nil, price: 100, quantity: 5, category_id: @category.id)
          @product.save
        end
        
        it "raises error 'Name can't be blank'" do
          expect(@product.errors.full_messages).to include("Name can't be blank")
        end
      end

      context "no price" do
        before do
          @category = Category.new(name: 'cat')
          @category.save
          @product = Product.new(name: 'producto', price: nil, quantity: 5, category_id: @category.id)
          @product.save
        end
        
        it "raises error 'Price can't be blank'" do
          expect(@product.errors.full_messages).to include("Price can't be blank")
        end
      end

      context "no quantity" do
        before do
          @category = Category.new(name: 'cat')
          @category.save
          @product = Product.new(name: 'producto', price: 100, quantity: nil, category_id: @category.id)
          @product.save
        end
        
        it "raises error 'Quantity can't be blank'" do
          expect(@product.errors.full_messages).to include("Quantity can't be blank")
        end
      end

      context "no category" do
        before do
          @category = Category.new(name: 'cat')
          @category.save
          @product = Product.new(name: 'producto', price: 100, quantity: 5, category_id: nil)
          @product.save
        end
        
        it "raises error 'Category can't be blank'" do
          expect(@product.errors.full_messages).to include("Category can't be blank")
        end
      end

    end

  end
end
