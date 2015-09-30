module HTML

    class AutoAttr

        attr_accessor 'hash', 'sorted'

        def initialize( hash = {}, sorted = 0 )
            @hash   = hash
            @sorted = sorted
        end

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

        def key( key )
            key = key.gsub( /\s+/, '' )
            key = key.gsub( /["'>=\/]/, '' )
            return key
        end

        def val( val )
            return '' if val.match( /^\s+$/ )
            val = val.gsub( /"/, '' )
            return val
        end

        def rotate( array )
            val = array.shift
            array.push( val )
            return val
        end

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

== SYNOPSIS

<code>
require 'HTML/AutoAttr'
attr = HTML::AutoAttr.new( { 'foo' => ['bar','baz','qux'] } )

4.times { puts attr.to_s }
</code>

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
