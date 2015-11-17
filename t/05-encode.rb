require "test/unit"
require "HTML/Encoder"

class TestHTML_Encoder < Test::Unit::TestCase

  def test_lower

        encoder = HTML::Encoder.new()

        assert_equal(
            '&amp;&lt;&gt;&quot;&apos;',
            encoder.encode( '&<>"\'' ),
            'default chars encoded when chars is nil'
        )

        assert_equal(
            '&amp;&lt;&gt;&quot;&apos;',
            encoder.encode( '&<>"\'', '' ),
            'encodes when chars is empty'
        )

        assert_equal(
            'hell&#48;',
            encoder.encode( 'hell0', 0 ),
            'zero encodes correctly'
        )

        assert_equal(
            'h&#101;llo',
            encoder.encode( 'hello', 'e' ),
            'requested chars encoded correctly'
        )

        assert_equal(
            '&amp;b&#97;r',
            encoder.encode( '&bar', 'a&' ),
            'ampersand is not double encoded'
        )

        assert_equal(
            'hello',
            encoder.encode( 'hello' ),
            'no encodes when default chars is nil'
        )

        assert_equal(
            'hello',
            encoder.encode( 'hello', '' ),
            'no encodes when default chars is empty'
        )

        deadbeef = 222.chr + 173.chr + 190.chr + 239.chr

        assert_equal(
            '&THORN;&shy;&frac34;&iuml;',
            encoder.encode( deadbeef, deadbeef ),
            'hex codes encoded correctly'
        )

        assert_equal(
            '&THORN;&shy;&frac34;&iuml;',
            encoder.encode( deadbeef ),
            'hex codes encoded correctly when chars is nil'
        )

        assert_equal(
            '&THORN;&shy;&frac34;&iuml;',
            encoder.encode( deadbeef, '' ),
            'hex codes encoded correctly when chars is empty'
        )

  end

  def test_numeric

        encoder = HTML::Encoder.new()

        assert_equal(
            '&#x26;',
            encoder.num_entity( '&' ),
            'char encoded numerically correctly'
        )

        assert_equal(
            '&#x26;&#x3C;&#x3E;&#x22;&#x27;',
            encoder.encode_hex( '&<>"\'' ),
            'default chars encoded numerically correctly'
        )

        assert_equal(
            '&amp;&lt;&gt;&quot;&apos;',
            encoder.encode( '&<>"\'' ),
            'does not impact default chars encoded correctly'
        )

        assert_equal(
            'hello',
            encoder.encode_hex( 'hello', '' ),
            'no chars encoded when no chars requested'
        )

        assert_equal(
            'h&#x65;llo',
            encoder.encode_hex( 'hello', 'e' ),
            'requested chars encoded correctly'
        )

        assert_equal(
            'h&#101;llo',
            encoder.encode( 'hello', 'e' ),
            'requested chars encoded correctly'
        )

  end

  def test_upper

        return unless RUBY_VERSION > '1.8.7'
        encoder = HTML::Encoder.new()

        str = eval( '8224.chr(Encoding::UTF_8)' )
        assert_equal(
            '&dagger;',
            encoder.encode( str, str ),
            'unicode char encoded correctly'
        )

        str = eval( '9824.chr(Encoding::UTF_8)+9827.chr(Encoding::UTF_8)+9829.chr(Encoding::UTF_8)+9830.chr(Encoding::UTF_8)' )
        assert_equal(
            '&spades;&clubs;&hearts;&diams;',
            encoder.encode( str, str ),
            'unicode chars encoded correctly'
        )
  end

end
