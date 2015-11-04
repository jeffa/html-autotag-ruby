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

                'OElig'    => 338.chr(Encoding::UTF_8),
                'oelig'    => 339.chr(Encoding::UTF_8),
                'Scaron'   => 352.chr(Encoding::UTF_8),
                'scaron'   => 353.chr(Encoding::UTF_8),
                'Yuml'     => 376.chr(Encoding::UTF_8),
                'fnof'     => 402.chr(Encoding::UTF_8),
                'circ'     => 710.chr(Encoding::UTF_8),
                'tilde'    => 732.chr(Encoding::UTF_8),
                'Alpha'    => 913.chr(Encoding::UTF_8),
                'Beta'     => 914.chr(Encoding::UTF_8),
                'Gamma'    => 915.chr(Encoding::UTF_8),
                'Delta'    => 916.chr(Encoding::UTF_8),
                'Epsilon'  => 917.chr(Encoding::UTF_8),
                'Zeta'     => 918.chr(Encoding::UTF_8),
                'Eta'      => 919.chr(Encoding::UTF_8),
                'Theta'    => 920.chr(Encoding::UTF_8),
                'Iota'     => 921.chr(Encoding::UTF_8),
                'Kappa'    => 922.chr(Encoding::UTF_8),
                'Lambda'   => 923.chr(Encoding::UTF_8),
                'Mu'       => 924.chr(Encoding::UTF_8),
                'Nu'       => 925.chr(Encoding::UTF_8),
                'Xi'       => 926.chr(Encoding::UTF_8),
                'Omicron'  => 927.chr(Encoding::UTF_8),
                'Pi'       => 928.chr(Encoding::UTF_8),
                'Rho'      => 929.chr(Encoding::UTF_8),
                'Sigma'    => 931.chr(Encoding::UTF_8),
                'Tau'      => 932.chr(Encoding::UTF_8),
                'Upsilon'  => 933.chr(Encoding::UTF_8),
                'Phi'      => 934.chr(Encoding::UTF_8),
                'Chi'      => 935.chr(Encoding::UTF_8),
                'Psi'      => 936.chr(Encoding::UTF_8),
                'Omega'    => 937.chr(Encoding::UTF_8),
                'alpha'    => 945.chr(Encoding::UTF_8),
                'beta'     => 946.chr(Encoding::UTF_8),
                'gamma'    => 947.chr(Encoding::UTF_8),
                'delta'    => 948.chr(Encoding::UTF_8),
                'epsilon'  => 949.chr(Encoding::UTF_8),
                'zeta'     => 950.chr(Encoding::UTF_8),
                'eta'      => 951.chr(Encoding::UTF_8),
                'theta'    => 952.chr(Encoding::UTF_8),
                'iota'     => 953.chr(Encoding::UTF_8),
                'kappa'    => 954.chr(Encoding::UTF_8),
                'lambda'   => 955.chr(Encoding::UTF_8),
                'mu'       => 956.chr(Encoding::UTF_8),
                'nu'       => 957.chr(Encoding::UTF_8),
                'xi'       => 958.chr(Encoding::UTF_8),
                'omicron'  => 959.chr(Encoding::UTF_8),
                'pi'       => 960.chr(Encoding::UTF_8),
                'rho'      => 961.chr(Encoding::UTF_8),
                'sigmaf'   => 962.chr(Encoding::UTF_8),
                'sigma'    => 963.chr(Encoding::UTF_8),
                'tau'      => 964.chr(Encoding::UTF_8),
                'upsilon'  => 965.chr(Encoding::UTF_8),
                'phi'      => 966.chr(Encoding::UTF_8),
                'chi'      => 967.chr(Encoding::UTF_8),
                'psi'      => 968.chr(Encoding::UTF_8),
                'omega'    => 969.chr(Encoding::UTF_8),
                'thetasym' => 977.chr(Encoding::UTF_8),
                'upsih'    => 978.chr(Encoding::UTF_8),
                'piv'      => 982.chr(Encoding::UTF_8),
                'ensp'     => 8194.chr(Encoding::UTF_8),
                'emsp'     => 8195.chr(Encoding::UTF_8),
                'thinsp'   => 8201.chr(Encoding::UTF_8),
                'zwnj'     => 8204.chr(Encoding::UTF_8),
                'zwj'      => 8205.chr(Encoding::UTF_8),
                'lrm'      => 8206.chr(Encoding::UTF_8),
                'rlm'      => 8207.chr(Encoding::UTF_8),
                'ndash'    => 8211.chr(Encoding::UTF_8),
                'mdash'    => 8212.chr(Encoding::UTF_8),
                'lsquo'    => 8216.chr(Encoding::UTF_8),
                'rsquo'    => 8217.chr(Encoding::UTF_8),
                'sbquo'    => 8218.chr(Encoding::UTF_8),
                'ldquo'    => 8220.chr(Encoding::UTF_8),
                'rdquo'    => 8221.chr(Encoding::UTF_8),
                'bdquo'    => 8222.chr(Encoding::UTF_8),
                'dagger'   => 8224.chr(Encoding::UTF_8),
                'Dagger'   => 8225.chr(Encoding::UTF_8),
                'bull'     => 8226.chr(Encoding::UTF_8),
                'hellip'   => 8230.chr(Encoding::UTF_8),
                'permil'   => 8240.chr(Encoding::UTF_8),
                'prime'    => 8242.chr(Encoding::UTF_8),
                'Prime'    => 8243.chr(Encoding::UTF_8),
                'lsaquo'   => 8249.chr(Encoding::UTF_8),
                'rsaquo'   => 8250.chr(Encoding::UTF_8),
                'oline'    => 8254.chr(Encoding::UTF_8),
                'frasl'    => 8260.chr(Encoding::UTF_8),
                'euro'     => 8364.chr(Encoding::UTF_8),
                'image'    => 8465.chr(Encoding::UTF_8),
                'weierp'   => 8472.chr(Encoding::UTF_8),
                'real'     => 8476.chr(Encoding::UTF_8),
                'trade'    => 8482.chr(Encoding::UTF_8),
                'alefsym'  => 8501.chr(Encoding::UTF_8),
                'larr'     => 8592.chr(Encoding::UTF_8),
                'uarr'     => 8593.chr(Encoding::UTF_8),
                'rarr'     => 8594.chr(Encoding::UTF_8),
                'darr'     => 8595.chr(Encoding::UTF_8),
                'harr'     => 8596.chr(Encoding::UTF_8),
                'crarr'    => 8629.chr(Encoding::UTF_8),
                'lArr'     => 8656.chr(Encoding::UTF_8),
                'uArr'     => 8657.chr(Encoding::UTF_8),
                'rArr'     => 8658.chr(Encoding::UTF_8),
                'dArr'     => 8659.chr(Encoding::UTF_8),
                'hArr'     => 8660.chr(Encoding::UTF_8),
                'forall'   => 8704.chr(Encoding::UTF_8),
                'part'     => 8706.chr(Encoding::UTF_8),
                'exist'    => 8707.chr(Encoding::UTF_8),
                'empty'    => 8709.chr(Encoding::UTF_8),
                'nabla'    => 8711.chr(Encoding::UTF_8),
                'isin'     => 8712.chr(Encoding::UTF_8),
                'notin'    => 8713.chr(Encoding::UTF_8),
                'ni'       => 8715.chr(Encoding::UTF_8),
                'prod'     => 8719.chr(Encoding::UTF_8),
                'sum'      => 8721.chr(Encoding::UTF_8),
                'minus'    => 8722.chr(Encoding::UTF_8),
                'lowast'   => 8727.chr(Encoding::UTF_8),
                'radic'    => 8730.chr(Encoding::UTF_8),
                'prop'     => 8733.chr(Encoding::UTF_8),
                'infin'    => 8734.chr(Encoding::UTF_8),
                'ang'      => 8736.chr(Encoding::UTF_8),
                'and'      => 8743.chr(Encoding::UTF_8),
                'or'       => 8744.chr(Encoding::UTF_8),
                'cap'      => 8745.chr(Encoding::UTF_8),
                'cup'      => 8746.chr(Encoding::UTF_8),
                'int'      => 8747.chr(Encoding::UTF_8),
                'there4'   => 8756.chr(Encoding::UTF_8),
                'sim'      => 8764.chr(Encoding::UTF_8),
                'cong'     => 8773.chr(Encoding::UTF_8),
                'asymp'    => 8776.chr(Encoding::UTF_8),
                'ne'       => 8800.chr(Encoding::UTF_8),
                'equiv'    => 8801.chr(Encoding::UTF_8),
                'le'       => 8804.chr(Encoding::UTF_8),
                'ge'       => 8805.chr(Encoding::UTF_8),
                'sub'      => 8834.chr(Encoding::UTF_8),
                'sup'      => 8835.chr(Encoding::UTF_8),
                'nsub'     => 8836.chr(Encoding::UTF_8),
                'sube'     => 8838.chr(Encoding::UTF_8),
                'supe'     => 8839.chr(Encoding::UTF_8),
                'oplus'    => 8853.chr(Encoding::UTF_8),
                'otimes'   => 8855.chr(Encoding::UTF_8),
                'perp'     => 8869.chr(Encoding::UTF_8),
                'sdot'     => 8901.chr(Encoding::UTF_8),
                'lceil'    => 8968.chr(Encoding::UTF_8),
                'rceil'    => 8969.chr(Encoding::UTF_8),
                'lfloor'   => 8970.chr(Encoding::UTF_8),
                'rfloor'   => 8971.chr(Encoding::UTF_8),
                'lang'     => 9001.chr(Encoding::UTF_8),
                'rang'     => 9002.chr(Encoding::UTF_8),
                'loz'      => 9674.chr(Encoding::UTF_8),
                'spades'   => 9824.chr(Encoding::UTF_8),
                'clubs'    => 9827.chr(Encoding::UTF_8),
                'hearts'   => 9829.chr(Encoding::UTF_8),
                'diams'    => 9830.chr(Encoding::UTF_8),
            }

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

            chars.to_s.each_char { |c|
                string = string.to_s.gsub( c, @char2entity[c] || num_entity(c) )
            }

            return string

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
