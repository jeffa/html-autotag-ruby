require "test/unit"
require "HTML/AutoTag"

class TestTag < Test::Unit::TestCase

    def test_init
        auto = HTML::AutoTag.new
        assert_equal( '', auto.encodes,  "no args encodes correct" )
        assert_equal( '', auto.indent,   "no args indent correct" )
        assert_equal(  0, auto.level,    "no args level correct" )
        assert_equal(  0, auto.sorted,   "no args sorted correct" )
        assert_equal( '', auto.newline,  "no args newline correct" )

        auto = HTML::AutoTag.new( 'encodes' => '<=&>', 'indent' => '   ' )
        assert_equal( '<=&>', auto.encodes, "encodes set correct" )
        assert_equal( '   ', auto.indent,   "indent set correct" )
        assert_equal( "\n", auto.newline,   "newline set correct" )
    end

    def test_empty
        auto = HTML::AutoTag.new
        assert_equal( '<hr />', auto.tag( 'tag' => 'hr' ),  "empty tag correct" )
    end

end
