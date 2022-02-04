class CheckoutController < ApplicationController
  before_action :authenticate_user!
  def cancel
    redirect_to carts_path, notice: 'تم الغاء عملية الدفع'
  end

  def success
    pp_request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new(params[:token])

    begin
      pp_response = PaypalClient.client.execute(pp_request)

      result = PaypalClient.openstruct_to_hash(pp_response.result)
      return redirect_to carts_path, notice: 'خطأ فى عملية الدفع' unless result[:status] == 'COMPLETED'

      order = nil
      Order.transaction do
        carts = current_user.carts
        order = current_user.orders.create!(products_count: carts.size, status: :paid, payment_id: result[:id])
        OrdersProduct.create!(carts.map { |item| { product_id: item.product_id, qt: item.qt, order_id: order.id } })
        current_user.carts.destroy_all
      end

      redirect_to "/orders/#{order.id}", success: 'تم انشاء طلبك بنجاح'
    rescue PayPalHttp::HttpError => e
      redirect_to carts_path, notice: 'خطأ فى عملية الدفع'
    end
  end

  def new
    carts = current_user.carts.all
    return redirect_to root_path, notice: 'اضف منتحات الى سلة المشتريات' unless carts.size.positive?

    pp_request = PayPalCheckoutSdk::Orders::OrdersCreateRequest.new
    pp_request.headers['prefer'] = 'return=representation'
    pp_request.request_body({
                              intent: 'CAPTURE',
                              application_context: {
                                return_url: "#{request.base_url}/checkout/success",
                                cancel_url: "#{request.base_url}/checkout/cancel",
                                brand_name: 'Cell Fashions',
                                landing_page: 'BILLING',
                                user_action: 'CONTINUE'
                              },
                              purchase_units: [
                                {
                                  amount: {
                                    currency_code: 'USD',
                                    value: Product.where(id: carts.pluck(:product_id)).sum(:price)
                                  }
                                }
                              ]
                            })

    begin
      pp_response = PaypalClient.client.execute(pp_request)

      result = PaypalClient.openstruct_to_hash(pp_response.result)

      return redirect_to carts_path, notice: 'خطأ غير معروف الرجاء المحاولة لاحقا' unless result[:status] == 'CREATED'

      capture_url = result[:links].select { |link| link[:rel] == 'approve' }.first&.[](:href)
      return redirect_to carts_path, notice: 'خطأ غير معروف الرجاء المحاولة لاحقا' unless capture_url.present?

      redirect_to capture_url
    rescue PayPalHttp::HttpError => e
      redirect_to carts_path, notice: 'خطأ غير معروف الرجاء المحاولة لاحقا'
    end
  end
end
