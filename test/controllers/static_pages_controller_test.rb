require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
    def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
    end

  test "should get root" do
  	get root_url
  	assert_response :success
  end

  test "should get home" do
    get "#{root_url}/static_pages/home"
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get help" do
    get "#{root_url}/static_pages/help"
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get "#{root_url}/static_pages/about"
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
  	get "#{root_url}/static_pages/contact"
  	assert_response :success
  	assert_select "title", "Contact | #{@base_title}"
  end

end
