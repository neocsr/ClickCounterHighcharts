require 'test_helper'

class BannerTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Banner.new.valid?
  end
end
