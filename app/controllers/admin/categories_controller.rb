class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(id: :asc).all
    @num_products = Product.select(:category_id).group(:category_id).count
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end
  
end
