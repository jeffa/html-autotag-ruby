require "test/unit"

class TestLoad < Test::Unit::TestCase

  def test_load
    assert_nothing_raised { require "HTML/AutoTag.rb" }
    assert_nothing_raised { require "HTML/AutoAttr.rb" }
    assert_nothing_raised { require "HTML/Encoder.rb" }

    if RUBY_VERSION > '1.8.7'
        assert_nothing_raised { require "HTML/Encoder/Unicode.rb" }
    end 

  end

end
