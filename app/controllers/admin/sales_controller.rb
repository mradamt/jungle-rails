class Admin::SalesController < ApplicationController

  def index
    @sales = Sale.order(:ends_on).all
  end

end
