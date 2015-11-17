require "test/unit"
require "HTML/AutoTag"

class TestTag < Test::Unit::TestCase

    def test_init
        auto = HTML::AutoTag.new
        assert_equal( false, auto.encode,   "no args encode correct" )
        assert_equal( nil, auto.encodes,    "no args encodes correct" )
        assert_equal( '', auto.indent,      "no args indent correct" )
        assert_equal(  0, auto.level,       "no args level correct" )
        assert_equal(  0, auto.sorted,      "no args sorted correct" )
        assert_equal( '', auto.newline,     "no args newline correct" )

        auto = HTML::AutoTag.new( 'encodes' => '<>', 'indent' => '   ' )
        assert_equal( true, auto.encode,    "encode set correct" )
        assert_equal( '<>', auto.encodes,   "encodes set correct" )
        assert_equal( '   ', auto.indent,   "indent set correct" )
        assert_equal( "\n", auto.newline,   "newline set correct" )
    end

    def test_empty
        auto = HTML::AutoTag.new
        assert_equal( '<hr />', auto.tag( 'tag' => 'hr' ),  "empty tag correct" )
    end

    def test_nonempty
        auto = HTML::AutoTag.new
        assert_equal( '<p>0</p>', auto.tag( 'tag' => 'p', 'cdata' => 0 ),  "paragraph tag correct" )
        assert_equal( '<ol><li>1</li></ol>', auto.tag( 'tag' => 'ol', 'cdata' => { 'tag' => 'li', 'cdata' => 1 } ),  "ol tag correct" )
        assert_equal( '<ol><li>1</li><li>2</li></ol>', auto.tag( 'tag' => 'ol', 'cdata' => [{ 'tag' => 'li', 'cdata' => 1 }, { 'tag' => 'li', 'cdata' => 2 }] ),  "ol tag correct" )
    end

    def test_indent
        auto = HTML::AutoTag.new( 'indent' => '  ' )
        assert_equal( "<p>0</p>\n", auto.tag( 'tag' => 'p', 'cdata' => 0 ),  "paragraph tag correct" )
        assert_equal( "<ol>\n  <li>1</li>\n</ol>\n", auto.tag( 'tag' => 'ol', 'cdata' => { 'tag' => 'li', 'cdata' => 1 } ),  "ol tag correct" )
        assert_equal( "<ol>\n  <li>1</li>\n  <li>2</li>\n</ol>\n", auto.tag( 'tag' => 'ol', 'cdata' => [{ 'tag' => 'li', 'cdata' => 1 }, { 'tag' => 'li', 'cdata' => 2 }] ),  "ol tag correct" )
    end

    def test_level
        auto = HTML::AutoTag.new( 'indent' => ' ',  'level' => 3 )
        assert_equal( "   <p>0</p>\n", auto.tag( 'tag' => 'p', 'cdata' => 0 ),  "paragraph tag correct" )
        assert_equal( "   <ol>\n    <li>1</li>\n   </ol>\n", auto.tag( 'tag' => 'ol', 'cdata' => { 'tag' => 'li', 'cdata' => 1 } ),  "ol tag correct" )
        assert_equal( "   <ol>\n    <li>1</li>\n    <li>2</li>\n   </ol>\n", auto.tag( 'tag' => 'ol', 'cdata' => [{ 'tag' => 'li', 'cdata' => 1 }, { 'tag' => 'li', 'cdata' => 2 }] ),  "ol tag correct" )
    end

    def test_encodes
        auto = HTML::AutoTag.new( 'encodes' => '<>' )
        assert_equal( '<p>&lt;0&gt;</p>', auto.tag( 'tag' => 'p', 'cdata' => '<0>' ),  "specific encodes work" )

        auto = HTML::AutoTag.new( 'encodes' => nil )
        assert_equal( '<p><"0\'&></p>', auto.tag( 'tag' => 'p', 'cdata' => '<"0\'&>' ),  "no encoding when encodes is nil" )

        auto = HTML::AutoTag.new( 'encodes' => 0 )
        assert_equal( '<p><&#48;></p>', auto.tag( 'tag' => 'p', 'cdata' => '<0>' ),  "zero only encode work" )

        auto = HTML::AutoTag.new
        assert_equal( '<p><0></p>', auto.tag( 'tag' => 'p', 'cdata' => '<0>' ),  "no encoding works" )
    end
end
