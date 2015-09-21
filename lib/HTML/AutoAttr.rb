module HTML

    class AutoAttr

        def key( key )
            key = key.gsub( /\s+/, '' )
            key = key.gsub( /["'>=\/]/, '' )
            return key
        end

        def val( val )
            val = '' if val.match( /^\s+$/ )
            val = val.gsub( /"/, '' )
            return val
        end

        def rotate( array )
            val = array.shift
            array.push( val )
            return val
        end

    end

end
