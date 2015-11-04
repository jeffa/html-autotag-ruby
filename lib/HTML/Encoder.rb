require "HTML/Encoder/Unicode.rb" if RUBY_VERSION > '1.8.7'

module HTML

    class Encoder

        def initialize()

            @entity2char = {
                'amp'   => '&',  # ampersand 
                'gt'    => '>',  # greater than
                'lt'    => '<',  # less than
                'quot'  => '"',  # double quote
                'apos'  => "'",  # single quote

                # PUBLIC ISO 8879-1986//ENTITIES Added Latin 1//EN//HTML
                'AElig'  => 198.chr,  # capital AE diphthong (ligature)
                'Aacute' => 193.chr,  # capital A, acute accent
                'Acirc'  => 194.chr,  # capital A, circumflex accent
                'Agrave' => 192.chr,  # capital A, grave accent
                'Aring'  => 197.chr,  # capital A, ring
                'Atilde' => 195.chr,  # capital A, tilde
                'Auml'   => 196.chr,  # capital A, dieresis or umlaut mark
                'Ccedil' => 199.chr,  # capital C, cedilla
                'ETH'    => 208.chr,  # capital Eth, Icelandic
                'Eacute' => 201.chr,  # capital E, acute accent
                'Ecirc'  => 202.chr,  # capital E, circumflex accent
                'Egrave' => 200.chr,  # capital E, grave accent
                'Euml'   => 203.chr,  # capital E, dieresis or umlaut mark
                'Iacute' => 205.chr,  # capital I, acute accent
                'Icirc'  => 206.chr,  # capital I, circumflex accent
                'Igrave' => 204.chr,  # capital I, grave accent
                'Iuml'   => 207.chr,  # capital I, dieresis or umlaut mark
                'Ntilde' => 209.chr,  # capital N, tilde
                'Oacute' => 211.chr,  # capital O, acute accent
                'Ocirc'  => 212.chr,  # capital O, circumflex accent
                'Ograve' => 210.chr,  # capital O, grave accent
                'Oslash' => 216.chr,  # capital O, slash
                'Otilde' => 213.chr,  # capital O, tilde
                'Ouml'   => 214.chr,  # capital O, dieresis or umlaut mark
                'THORN'  => 222.chr,  # capital THORN, Icelandic
                'Uacute' => 218.chr,  # capital U, acute accent
                'Ucirc'  => 219.chr,  # capital U, circumflex accent
                'Ugrave' => 217.chr,  # capital U, grave accent
                'Uuml'   => 220.chr,  # capital U, dieresis or umlaut mark
                'Yacute' => 221.chr,  # capital Y, acute accent
                'aacute' => 225.chr,  # small a, acute accent
                'acirc'  => 226.chr,  # small a, circumflex accent
                'aelig'  => 230.chr,  # small ae diphthong (ligature)
                'agrave' => 224.chr,  # small a, grave accent
                'aring'  => 229.chr,  # small a, ring
                'atilde' => 227.chr,  # small a, tilde
                'auml'   => 228.chr,  # small a, dieresis or umlaut mark
                'ccedil' => 231.chr,  # small c, cedilla
                'eacute' => 233.chr,  # small e, acute accent
                'ecirc'  => 234.chr,  # small e, circumflex accent
                'egrave' => 232.chr,  # small e, grave accent
                'eth'    => 240.chr,  # small eth, Icelandic
                'euml'   => 235.chr,  # small e, dieresis or umlaut mark
                'iacute' => 237.chr,  # small i, acute accent
                'icirc'  => 238.chr,  # small i, circumflex accent
                'igrave' => 236.chr,  # small i, grave accent
                'iuml'   => 239.chr,  # small i, dieresis or umlaut mark
                'ntilde' => 241.chr,  # small n, tilde
                'oacute' => 243.chr,  # small o, acute accent
                'ocirc'  => 244.chr,  # small o, circumflex accent
                'ograve' => 242.chr,  # small o, grave accent
                'oslash' => 248.chr,  # small o, slash
                'otilde' => 245.chr,  # small o, tilde
                'ouml'   => 246.chr,  # small o, dieresis or umlaut mark
                'szlig'  => 223.chr,  # small sharp s, German (sz ligature)
                'thorn'  => 254.chr,  # small thorn, Icelandic
                'uacute' => 250.chr,  # small u, acute accent
                'ucirc'  => 251.chr,  # small u, circumflex accent
                'ugrave' => 249.chr,  # small u, grave accent
                'uuml'   => 252.chr,  # small u, dieresis or umlaut mark
                'yacute' => 253.chr,  # small y, acute accent
                'yuml'   => 255.chr,  # small y, dieresis or umlaut mark

                # Some extra Latin 1 chars that are listed in the HTML3.2 draft (21-May-96)
                'copy'   => 169.chr,  # copyright sign
                'reg'    => 174.chr,  # registered sign
                'nbsp'   => 160.chr,  # non breaking space

                # Additional ISO-8859/1 entities listed in rfc1866 (section 14)
                'iexcl'  => 161.chr,
                'cent'   => 162.chr,
                'pound'  => 163.chr,
                'curren' => 164.chr,
                'yen'    => 165.chr,
                'brvbar' => 166.chr,
                'sect'   => 167.chr,
                'uml'    => 168.chr,
                'ordf'   => 170.chr,
                'laquo'  => 171.chr,
                'not'    => 172.chr,    # not is a keyword in perl
                'shy'    => 173.chr,
                'macr'   => 175.chr,
                'deg'    => 176.chr,
                'plusmn' => 177.chr,
                'sup1'   => 185.chr,
                'sup2'   => 178.chr,
                'sup3'   => 179.chr,
                'acute'  => 180.chr,
                'micro'  => 181.chr,
                'para'   => 182.chr,
                'middot' => 183.chr,
                'cedil'  => 184.chr,
                'ordm'   => 186.chr,
                'raquo'  => 187.chr,
                'frac14' => 188.chr,
                'frac12' => 189.chr,
                'frac34' => 190.chr,
                'iquest' => 191.chr,
                'times'  => 215.chr,    # times is a keyword in perl
                'divide' => 247.chr,
            }

            if RUBY_VERSION > '1.8.7'
                HTML::Encoder::Unicode.unicode_mapping.each{ |k,v|
                    @entity2char[k] = v
                }
            end

            @char2entity = Hash[@entity2char.map { |k, v| [v, "&#{k};"] }]

            for i in 0..255
                unless @char2entity.has_key?( i.chr )
                    @char2entity[i.chr] = "&##{i};";
                end
            end

        end

        def encode( *args )

            string = args[0]
            chars  = args[1].nil? ? '&<>"\'' : args[1]

            lookup = {}
            chars.to_s.each_char{ |c|
                lookup[c] = @char2entity[c] || num_entity(c)
            }

            encoded = ''
            string.to_s.each_char { |c|
                if lookup[c]
                    encoded += @char2entity[c] || num_entity(c)
                else
                    encoded += c
                end
            }

            return encoded

        end

        def encode_hex( *args )
            tmp = @char2entity
            @char2entity = {}
            string = encode( *args )
            @char2entity = tmp
            return string
        end

        def num_entity( char )
            return sprintf( '&#x%X;', char.unpack('C')[0] )
        end

    end

end

=begin rdoc

== INSPIRATION

This code is heavily borrowed from Gisle Aas's CPAN module HTML::Entities.

== AUTHOR

Jeff Anderson, <jeffa at cpan.org>

== LICENSE AND COPYRIGHT

Copyright 2015 Jeff Anderson. (See License.md shipped with distro)

=end
