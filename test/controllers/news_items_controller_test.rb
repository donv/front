require File.dirname(__FILE__) + '/../test_helper'

class NewsItemsControllerTest < ActionController::TestCase
  fixtures :news_items

  def setup
    @first_id = news_items(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:news_items)
  end

  def test_show
    get :show, params: {:id => @first_id}

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:news_item)
    assert assigns(:news_item).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:news_item)
  end

  def test_create
    num_news_items = NewsItem.count

    post :create, params: {news_item: {title: 'A new news item', body: 'A new body!'}}
    assert_no_errors :news_item

    assert_response :redirect
    assert_redirected_to root_path

    assert_equal num_news_items + 1, NewsItem.count
  end

  def test_edit
    get :edit, params: {id: @first_id}

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:news_item)
    assert assigns(:news_item).valid?
  end

  def test_update
    post :update, params: {id: @first_id, news_item:{title: 'changed news item title'}}
    assert_response :redirect
    assert_redirected_to root_path
  end

  def test_destroy
    assert_nothing_raised {
      NewsItem.find(@first_id)
    }

    post :destroy, params: {id: @first_id}
    assert_response :redirect
    assert_redirected_to action: :list

    assert_raise(ActiveRecord::RecordNotFound) {
      NewsItem.find(@first_id)
    }
  end
end
