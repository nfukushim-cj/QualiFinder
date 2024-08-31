require "test_helper"

class DraftControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get draft_index_url
    assert_response :success
  end
end
