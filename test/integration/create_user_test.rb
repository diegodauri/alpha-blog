require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest
  test "get new user form and sign up" do
    get "/signup"
    assert_response :success
    assert_difference "User.count", 1 do
      post users_path, params: { user: { email: "jhonedoe@example.com", username: "Jhon Doe", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert session[:user_id]
    assert_match "Jhon Doe", response.body  
    assert_select "div.alert"
  end
end
