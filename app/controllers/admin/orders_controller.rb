class Admin::OrdersController < Admin::ApplicationController
  before_action :set_order, only: %i[show destroy]

  def index
    @orders = Order.order(id: :desc).page params[:page]
  end

  def show; end

  def destroy
    @order.destroy
    redirect_to admin_orders_path, notice: 'تم حذف الطلب'
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
