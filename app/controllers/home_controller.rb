class HomeController < ApplicationController
  def index
    @products = Product.order(id: :desc).limit(20)
  end
end
