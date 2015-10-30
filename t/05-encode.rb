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

  def test_container


  end

  def container( params = {} )
        encoder = HTML::Encoder.new()
        return encoder.encode( params['rendered'], params['encodes'] ) 
  end

end
