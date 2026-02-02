# store/test/controllers/sign_ups_controller_test.rb
require "test_helper"

class SignupsControllerTest < ActionDispatch::IntegrationTest
  test "view sign up" do
    get sign_up_path
    assert_response :success
  end

  test "view sign up when authenticated" do
    sign_in_as users(:one)
    get sign_up_path
    assert_redirected_to root_path
  end

  test "sucessful sign up" do
    assert_difference "User.count" do
      post sign_up_path, params: { user: { first_name: "Example", last_name: "User", email_address: "example@user.org", password: "Password123!", password_confirmation: "Password123!" } }
      assert_redirected_to root_path
    end
  end

  test "invalid sign up" do
    assert_no_difference "User.count" do
      post sign_up_path, params: { user: { email_address: "example@user.org", password: "Password123!", password_confirmation: "Password123!" } }
      assert_response :unprocessable_entity
    end
  end

  test "sign up ignores admin attribute" do
    assert_difference "User.count" do
      post sign_up_path, params: { user: { first_name: "Example", last_name: "User", email_address: "example@user.org", password: "Password123!", password_confirmation: "Password123!", admin: true } }
      assert_redirected_to root_path
    end
    refute User.find_by(email_address: "example@user.org").admin?
  end
end
