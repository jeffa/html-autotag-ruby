module HTML

    class AutoAttr

        attr_accessor 'hash', 'sorted'

        def initialize( hash = {}, sorted = 0 )
            @hash   = hash
            @sorted = sorted
        end

        def to_s

        end

        def key( key )
            key.gsub!( /\s+/, '' )
            key.gsub!( /["'>=\/]/, '' )
            return key
        end

        def val( val )
            return '' if val.match( /^\s+$/ )
            val.gsub!( /"/, '' )
            return val
        end

        def rotate( array )
            val = array.shift
            array.push( val )
            return val
        end

    end

end
