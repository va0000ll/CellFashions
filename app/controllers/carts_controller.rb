class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: %i[destroy increment decrement]

  def index
    @carts = current_user.carts.select('carts.*, products.name, products.price').joins(:product).all
  end

  def create
    cart = current_user.carts.find_by_product_id(params[:product_id])

    if cart
      cart.increment!(:qt)
    else
      cart = current_user.carts.create!(product_id: params[:product_id], qt: 1)
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'تمت الاضافة للسلة' }
      format.json { render json: { status: :ok, cart: cart } }
    end
  end

  def destroy
    @cart.destroy

    respond_to do |format|
      format.json { render json: { status: :ok, cart: @cart } }
      format.any { redirect_to carts_path, notice: 'تم حذف  المنتج من سلة المشتريات' }
    end
  end

  def increment
    @cart.increment!(:qt)
    respond_to do |format|
      format.json { render json: { status: :ok, cart: @cart } }
      format.any { redirect_to carts_path, notice: 'تم تحديث السلة' }
    end
  end

  def decrement
    @cart.decrement!(:qt)
    @cart.destroy unless @cart.qt.positive?

    respond_to do |format|
      format.json { render json: { status: :ok, cart: @cart } }
      format.any { redirect_to carts_path, notice: 'تم تحديث السلة' }
    end
  end

  private

  def set_cart
    @cart = current_user.carts.find_by_product_id(params[:id])
    puts "@cart: #{@cart}"
  end
end
