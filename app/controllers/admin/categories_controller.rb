class Admin::CategoriesController < Admin::ApplicationController
  before_action :set_category, only: %i[edit update show destroy]
  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    return redirect_to [:admin, @category], notice: 'تم اضافة القسم' if @category

    render :new
  end

  def edit
  end

  def update
    @category.update(category_params)
    redirect_to [:admin, @category], notice: 'تم تعديل القسم'
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'تم حذف القسم'
  end

  private

  def category_params
    params.required(:category).permit(:name, :description)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
