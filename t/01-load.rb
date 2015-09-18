require "test/unit"

class TestLoad < Test::Unit::TestCase

  def test_load
    assert_nothing_raised { require "HTML/AutoTag.rb" }
  end

end
