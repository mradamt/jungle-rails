require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.new(name: 'valid')
      @category.save
      @product = Product.new(
        name: 'horse',
        price: 100,
        quantity: 5,
        category_id: @category.id
      )
      @product.save
      # byebug
    end
    
    it "new product saves successfully" do
      expect(Product.last).to eq(@product)
    end

    

  end
end
