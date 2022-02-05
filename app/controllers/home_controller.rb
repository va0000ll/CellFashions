class HomeController < ApplicationController
  def index
    @products = Product.by_category(params[:category_id]).order(id: :desc).limit(20)
  end
end
