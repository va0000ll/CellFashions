class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders.page params[:page]
  end

  def show
    @order = current_user.orders.find(params[:id])
    @products = @order.products.select('products.*, orders_products.qt')
  end
end
