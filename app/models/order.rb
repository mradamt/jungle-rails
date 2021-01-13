class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :update_inventory

  private

  def update_inventory
    order = LineItem.where(order_id: self.id)
    order.each do |lineItem|
      @product = Product.find(lineItem[:product_id])
      delta = @product[:quantity] - lineItem[:quantity]
      @product.update(quantity: delta)
    end
  end

end
