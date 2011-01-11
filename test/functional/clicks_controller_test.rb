require 'test_helper'

class ClicksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Click.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Click.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to clicks_url
  end
  
  def test_edit
    get :edit, :id => Click.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Click.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Click.first
    assert_template 'edit'
  end

  def test_update_valid
    Click.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Click.first
    assert_redirected_to clicks_url
  end
  
  def test_destroy
    click = Click.first
    delete :destroy, :id => click
    assert_redirected_to clicks_url
    assert !Click.exists?(click.id)
  end
end
