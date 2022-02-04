require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get carts_create_url
    assert_response :success
  end

  test "should get destroy" do
    get carts_destroy_url
    assert_response :success
  end

  test "should get increment" do
    get carts_increment_url
    assert_response :success
  end

  test "should get decrement" do
    get carts_decrement_url
    assert_response :success
  end
end
