require 'test_helper'

class GiphyApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GiphyApi::VERSION
  end
end
