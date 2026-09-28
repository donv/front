# frozen_string_literal: true

require 'test_helper'

# The engines render inside front's layout, so a layout regression only shows up when their pages
# are requested through the host application.
class EnginesTest < ActionDispatch::IntegrationTest
  def test_blog_index_renders_in_the_host_layout
    Blog.create!(title: 'Test blog')
    get '/blog'
    assert_response :success
  end
end
