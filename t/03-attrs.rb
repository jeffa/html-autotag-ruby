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

end
