class Admin::ProductsController < Admin::ApplicationController
  before_action :set_product, only: %i[edit update show destroy]
  def index
    @products = Product.page params[:page]
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    return redirect_to [:admin, @product], notice: 'تم اضافة المنتج' if @product

    render :new
  end

  def edit; end

  def update
    @product.update(product_params)
    redirect_to [:admin, @product], notice: 'تم تعديل المنتج'
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'تم حذف المنتج'
  end

  private

  def product_params
    params.required(:product).permit(:name, :description, :keywords, :category_id, :price, :image)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
