# frozen_string_literal: true

require 'test_helper'

# The engines render inside front's layout, so a layout regression only shows up when their pages
# are requested through the host application.
class EnginesTest < ActionDispatch::IntegrationTest
  def test_blog_index_renders_in_the_host_layout
    blog = Blog.create!(title: 'Test blog')
    get '/blog'
    assert_response :success
    assert_select 'title', "#{I18n.t(:blog)} - Test blog"
    assert_select '#introtext h1', I18n.t(:blog)
    assert_select '#rightcol .rblock h4', I18n.t(:blogs)
    assert_select "#rightcol a[href='/blog/blogs/#{blog.id}']", 'Test blog'
  end
end
