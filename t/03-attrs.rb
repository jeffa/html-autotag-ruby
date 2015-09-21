require "test/unit"
require "HTML/AutoAttr"

class TestAttrs < Test::Unit::TestCase

    def test_keys

        attr = HTML::AutoAttr.new
        assert_equal( '', attr.key( '  ' ),             "only spaces" )
        assert_equal( 'foobar', attr.key( 'foo bar'),   "with space" )
        assert_equal( '', attr.key( '">=//=>"' ),       "only scrubbed chars" )
        assert_equal( 'foo<bar', attr.key( 'foo<bar' ), "does not scrub < char" )

    end

    def test_vals

        attr = HTML::AutoAttr.new
        assert_equal( '', attr.val( '  ' ),             "only spaces" )
        assert_equal( 'foo bar', attr.val( 'foo bar'),  "with space" )
        assert_equal( "'foo'", attr.val( "'foo'" ),     "single quotes are not scrubbed" )
        assert_equal( 'foo', attr.val( '"foo"' ),       "double quotes are scrubbed" )

    end

    def test_simple_attrs
        attr = HTML::AutoAttr.new( { 'foo' => 'bar', 'baz' => 'qux' }, 1 )
        assert_equal( ' foo="bar"', attr.to_s,          "correct simple attrs" )
    end

    def test_rotate_attrs
        attr = HTML::AutoAttr.new( { 'foo' => ['bar','baz','qux'], 'baz' => ['foo','qux'] }, 1 )
        assert_equal( ' foo="bar"', attr.to_s,          "correct simple attrs" )
    end

end
