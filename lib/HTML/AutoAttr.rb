module HTML

    class AutoAttr

        attr_accessor 'hash', 'sorted'

        # expects the following arguments
        #   * hash
        #       Contains attribute keys and values
        #
        #   * sorted
        #       Boolean. Whether or not to render attributes in alphabetical order.
        #
        def initialize( hash = {}, sorted = 0 )
            @hash   = hash
            @sorted = sorted
        end

        # expects no arguments, emits string containing rendered key/value pairs
        #
        def to_s

            return '' unless @hash.kind_of?( Hash )
            keys = @sorted ? @hash.keys.sort : @hash.keys
            str  = ''
            seen = {}

            keys.each do |key|
                unless seen.has_key?( key )
                    val = @hash[key]
                    val = stringify( val )  if val.kind_of?( Hash )
                    val = rotate( val )     if val.kind_of?( Array )
                    str += sprintf( ' %s="%s"', key( key ), val( val ) )
                end
                seen[key] = 1
            end

            return str
        end

        # expects one argument: the key to scrub
        def key( key )
            key = key.gsub( /\s+/, '' )
            key = key.gsub( /["'>=\/]/, '' )
            return key
        end

        # expects one argument: the value to scrub
        def val( val )
            return '' if val.match( /^\s+$/ )
            val = val.gsub( /"/, '' )
            return val
        end

        # expects one argument: the array to rotate
        # returns the first element before array is rotated
        def rotate( array )
            val = array.shift
            array.push( val )
            return val
        end

        # expects one argument: the hash to 'stringify'
        def stringify( hash )

            keys = @sorted ? hash.keys.sort : hash.keys
            vals = keys.map{ |key|
                val = ''
                if hash[key].kind_of?( Array ) 
                    val = rotate( hash[key] )
                elsif hash[key].kind_of?( Hash )
                    val = @sorted ? hash[key].keys.sort[0] : hash[key].keys[0]
                else
                    val = hash[key]
                end
                "#{key}: #{val}"
            }
            return vals.join( '; ' ) + (vals.length ? ';' : '')

        end

    end

end

=begin rdoc

= NAME

HTML::AutoAttr - Just another HTML attribute generator.

== DESCRIPTION

This module will translate nested hash keys and values into HTML
tag attributes that can have ther values automatically rotated.

== SEE ALSO

* http://www.w3.org/TR/html5/syntax.html#attributes-0

* http://www.w3.org/TR/html-markup/syntax.html#syntax-attributes

== GITHUB

The Github project is https://github.com/jeffa/html-autotag-ruby

== SUPPORT

You can find documentation for this module with the ri command.

ri HTML::AutoAttr

== AUTHOR

Jeff Anderson, <jeffa at cpan.org>

== LICENSE AND COPYRIGHT

Copyright 2015 Jeff Anderson. (See License.md shipped with distro)

=end
