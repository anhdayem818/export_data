require 'test_helper'

class ConvertToHtmlControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get convert_to_html_index_url
    assert_response :success
  end

  test "should get convert" do
    get convert_to_html_convert_url
    assert_response :success
  end

  test "should get export" do
    get convert_to_html_export_url
    assert_response :success
  end

  test "should get parse_data" do
    get convert_to_html_parse_data_url
    assert_response :success
  end

end
