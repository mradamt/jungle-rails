class Admin::DashboardController < ApplicationController

  before_filter :authorize

  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
