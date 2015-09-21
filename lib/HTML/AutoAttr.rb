module HTML

    class AutoAttr

        attr_accessor 'hash', 'sorted'

        def initialize( hash = {}, sorted = 0 )
            @hash   = hash
            @sorted = sorted
        end

        def to_s

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
