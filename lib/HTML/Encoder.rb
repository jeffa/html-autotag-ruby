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

=begin comment
                'OElig'    => 338.chr,
                'oelig'    => 339.chr,
                'Scaron'   => 352.chr,
                'scaron'   => 353.chr,
                'Yuml'     => 376.chr,
                'fnof'     => 402.chr,
                'circ'     => 710.chr,
                'tilde'    => 732.chr,
                'Alpha'    => 913.chr,
                'Beta'     => 914.chr,
                'Gamma'    => 915.chr,
                'Delta'    => 916.chr,
                'Epsilon'  => 917.chr,
                'Zeta'     => 918.chr,
                'Eta'      => 919.chr,
                'Theta'    => 920.chr,
                'Iota'     => 921.chr,
                'Kappa'    => 922.chr,
                'Lambda'   => 923.chr,
                'Mu'       => 924.chr,
                'Nu'       => 925.chr,
                'Xi'       => 926.chr,
                'Omicron'  => 927.chr,
                'Pi'       => 928.chr,
                'Rho'      => 929.chr,
                'Sigma'    => 931.chr,
                'Tau'      => 932.chr,
                'Upsilon'  => 933.chr,
                'Phi'      => 934.chr,
                'Chi'      => 935.chr,
                'Psi'      => 936.chr,
                'Omega'    => 937.chr,
                'alpha'    => 945.chr,
                'beta'     => 946.chr,
                'gamma'    => 947.chr,
                'delta'    => 948.chr,
                'epsilon'  => 949.chr,
                'zeta'     => 950.chr,
                'eta'      => 951.chr,
                'theta'    => 952.chr,
                'iota'     => 953.chr,
                'kappa'    => 954.chr,
                'lambda'   => 955.chr,
                'mu'       => 956.chr,
                'nu'       => 957.chr,
                'xi'       => 958.chr,
                'omicron'  => 959.chr,
                'pi'       => 960.chr,
                'rho'      => 961.chr,
                'sigmaf'   => 962.chr,
                'sigma'    => 963.chr,
                'tau'      => 964.chr,
                'upsilon'  => 965.chr,
                'phi'      => 966.chr,
                'chi'      => 967.chr,
                'psi'      => 968.chr,
                'omega'    => 969.chr,
                'thetasym' => 977.chr,
                'upsih'    => 978.chr,
                'piv'      => 982.chr,
                'ensp'     => 8194.chr,
                'emsp'     => 8195.chr,
                'thinsp'   => 8201.chr,
                'zwnj'     => 8204.chr,
                'zwj'      => 8205.chr,
                'lrm'      => 8206.chr,
                'rlm'      => 8207.chr,
                'ndash'    => 8211.chr,
                'mdash'    => 8212.chr,
                'lsquo'    => 8216.chr,
                'rsquo'    => 8217.chr,
                'sbquo'    => 8218.chr,
                'ldquo'    => 8220.chr,
                'rdquo'    => 8221.chr,
                'bdquo'    => 8222.chr,
                'dagger'   => 8224.chr,
                'Dagger'   => 8225.chr,
                'bull'     => 8226.chr,
                'hellip'   => 8230.chr,
                'permil'   => 8240.chr,
                'prime'    => 8242.chr,
                'Prime'    => 8243.chr,
                'lsaquo'   => 8249.chr,
                'rsaquo'   => 8250.chr,
                'oline'    => 8254.chr,
                'frasl'    => 8260.chr,
                'euro'     => 8364.chr,
                'image'    => 8465.chr,
                'weierp'   => 8472.chr,
                'real'     => 8476.chr,
                'trade'    => 8482.chr,
                'alefsym'  => 8501.chr,
                'larr'     => 8592.chr,
                'uarr'     => 8593.chr,
                'rarr'     => 8594.chr,
                'darr'     => 8595.chr,
                'harr'     => 8596.chr,
                'crarr'    => 8629.chr,
                'lArr'     => 8656.chr,
                'uArr'     => 8657.chr,
                'rArr'     => 8658.chr,
                'dArr'     => 8659.chr,
                'hArr'     => 8660.chr,
                'forall'   => 8704.chr,
                'part'     => 8706.chr,
                'exist'    => 8707.chr,
                'empty'    => 8709.chr,
                'nabla'    => 8711.chr,
                'isin'     => 8712.chr,
                'notin'    => 8713.chr,
                'ni'       => 8715.chr,
                'prod'     => 8719.chr,
                'sum'      => 8721.chr,
                'minus'    => 8722.chr,
                'lowast'   => 8727.chr,
                'radic'    => 8730.chr,
                'prop'     => 8733.chr,
                'infin'    => 8734.chr,
                'ang'      => 8736.chr,
                'and'      => 8743.chr,
                'or'       => 8744.chr,
                'cap'      => 8745.chr,
                'cup'      => 8746.chr,
                'int'      => 8747.chr,
                'there4'   => 8756.chr,
                'sim'      => 8764.chr,
                'cong'     => 8773.chr,
                'asymp'    => 8776.chr,
                'ne'       => 8800.chr,
                'equiv'    => 8801.chr,
                'le'       => 8804.chr,
                'ge'       => 8805.chr,
                'sub'      => 8834.chr,
                'sup'      => 8835.chr,
                'nsub'     => 8836.chr,
                'sube'     => 8838.chr,
                'supe'     => 8839.chr,
                'oplus'    => 8853.chr,
                'otimes'   => 8855.chr,
                'perp'     => 8869.chr,
                'sdot'     => 8901.chr,
                'lceil'    => 8968.chr,
                'rceil'    => 8969.chr,
                'lfloor'   => 8970.chr,
                'rfloor'   => 8971.chr,
                'lang'     => 9001.chr,
                'rang'     => 9002.chr,
                'loz'      => 9674.chr,
                'spades'   => 9824.chr,
                'clubs'    => 9827.chr,
                'hearts'   => 9829.chr,
                'diams'    => 9830.chr,
=end
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

            #$chars =~ s,(?<!\\)([]/]),\\$1,g;
            #$chars =~ s,(?<!\\)\\\z,\\\\,;
            chars.each_char { |c|
                string = string.gsub( c, @char2entity[c] )
            }

            return string

        end

        def decode()

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
