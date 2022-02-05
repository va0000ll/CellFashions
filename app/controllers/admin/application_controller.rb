class Admin::ApplicationController < ActionController::Base
  layout 'layouts/admin'
  before_action :authenticate

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == 'admin' && md5_of_password == '21232f297a57a5a743894a0e4a801fc3'
    end
  end
end
