require 'test_helper'

class BannersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Banner.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Banner.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to banners_url
  end
  
  def test_edit
    get :edit, :id => Banner.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Banner.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Banner.first
    assert_template 'edit'
  end

  def test_update_valid
    Banner.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Banner.first
    assert_redirected_to banners_url
  end
  
  def test_destroy
    banner = Banner.first
    delete :destroy, :id => banner
    assert_redirected_to banners_url
    assert !Banner.exists?(banner.id)
  end
end
