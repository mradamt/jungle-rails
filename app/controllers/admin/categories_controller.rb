class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(id: :asc).all
    @num_products = Product.select(:category_id).group(:category_id).count
  end

  def new
  end

  def create
  end
end
