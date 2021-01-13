class Admin::ProductsController < Admin::BaseController

  def index
    @products = Product.order(id: :desc).all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  def add_inventory
    product_id = params[:product_id].to_s
    modify_inventory_delta(product_id, +1)

    redirect_to :back
  end

  def remove_inventory
    product_id = params[:product_id].to_s
    modify_inventory_delta(product_id, -1)

    redirect_to :back
  end

  private
  
  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end
  
  def modify_inventory_delta(product_id, delta)
    @product = Product.find(product_id)
    new_quantity = @product[:quantity] + delta
    @product.update(quantity: new_quantity)
  end

end
