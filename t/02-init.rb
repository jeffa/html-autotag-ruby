require "test/unit"
require "HTML/AutoTag"

class TestInit < Test::Unit::TestCase

    def test_init

        tag = HTML::AutoTag.new
        assert_equal( '', tag.encodes,  "no args encodes correct" )
        assert_equal( '', tag.indent,   "no args indent correct" )
        assert_equal(  0, tag.level,    "no args level correct" )
        assert_equal( '', tag.newline,  "no args newline correct" )

    end

end
