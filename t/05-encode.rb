require "test/unit"
require "HTML/Encoder"

class TestHTML_Encoder < Test::Unit::TestCase

  def test_lower

        encoder = HTML::Encoder.new()

        assert_equal(
            '&amp;&lt;&gt;&quot;&apos;',
            encoder.encode( '&<>"\'' ),
            'default chars encoded correctly'
        )

        assert_equal(
            '&<>"\'',
            encoder.encode( '&<>"\'', '' ),
            'no encodes when chars is empty'
        )
        assert_equal(
            'h&#101;llo',
            encoder.encode( 'hello', 'e' ),
            'requested chars encoded correctly'
        )

        assert_equal(
            'hello',
            encoder.encode( 'hello' ),
            'no encodes when default chars requested'
        )

        assert_equal(
            'hello',
            encoder.encode( 'hello', '' ),
            'no chars encoded when no chars requested'
        )

        deadbeef = 222.chr + 173.chr + 190.chr + 239.chr

        assert_equal(
            '&THORN;&shy;&frac34;&iuml;',
            encoder.encode( deadbeef, deadbeef ),
            'hex codes encoded correctly'
        )

        assert_equal(
            deadbeef,
            encoder.encode( deadbeef ),
            'no encodes when default chars requested'
        )

        assert_equal(
            deadbeef,
            encoder.encode( deadbeef, '' ),
            'no encodes when no chars requested'
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

        encoder = HTML::Encoder.new()

        assert_equal(
            '&dagger;',
            encoder.encode( 8224.chr(Encoding::UTF_8), 8224.chr(Encoding::UTF_8) ),
            'unicode char encoded correctly'
        )

        str = 9824.chr(Encoding::UTF_8)+9827.chr(Encoding::UTF_8)+9829.chr(Encoding::UTF_8)+9830.chr(Encoding::UTF_8)

        assert_equal(
            '&spades;&clubs;&hearts;&diams;',
            encoder.encode( str, str ),
            'unicode chars encoded correctly'
        )
  end

end
