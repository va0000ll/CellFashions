class OrdersController < ApplicationController
  def index
    @orders = Order.page params[:page]
  end

  def show
    @order = Order.find(params[:id])
    @products = @order.products.select('products.*, orders_products.qt')
  end
end
