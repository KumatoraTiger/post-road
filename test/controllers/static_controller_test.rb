require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get privacypolicy" do
    get static_privacypolicy_url
    assert_response :success
  end

  test "should get term" do
    get static_term_url
    assert_response :success
  end

end
