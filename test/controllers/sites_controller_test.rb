require File.dirname(__FILE__) + '/../test_helper'

class SitesControllerTest < ActionController::TestCase
  fixtures :sites

  def setup
    @first_id = sites(:first).id
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

    assert_not_nil assigns(:sites)
  end

  def test_show
    get :show, params: {:id => @first_id}

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:site)
    assert assigns(:site).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:site)
  end

  def test_create
    num_sites = Site.count

    post :create, params: {site: {title: 'new site', welcome_text: 'new welcome text'}}
    assert_no_errors :site

    assert_response :redirect
    assert_redirected_to action: :list

    assert_equal num_sites + 1, Site.count
  end

  def test_edit
    get :edit, params: {id: @first_id}

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:site)
    assert assigns(:site).valid?
  end

  def test_update
    post :update, params:{id: @first_id, site: {title: 'changed title'}}
    assert_response :redirect
    assert_redirected_to action: :show, id: @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Site.find(@first_id)
    }

    post :destroy, params: {id: @first_id}
    assert_response :redirect
    assert_redirected_to action: :list

    assert_raise(ActiveRecord::RecordNotFound) {
      Site.find(@first_id)
    }
  end
end
