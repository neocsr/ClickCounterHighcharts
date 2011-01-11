require 'test_helper'

class ClickTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Click.new.valid?
  end
end
