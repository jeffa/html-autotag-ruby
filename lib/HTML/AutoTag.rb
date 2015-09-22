require "HTML/AutoTag/version"
require "HTML/AutoAttr"

module HTML

  class AutoTag

        attr_accessor 'encodes', 'indent', 'level', 'sorted', 'newline'

        def initialize( params = {} )
            @encodes    = params['encodes'] || ''
            @indent     = params['indent']  || ''
            @level      = params['level']   || 0
            @sorted     = params['sorted']  || 0
            @newline    = params['indent'] ? "\n" : ''

        end

        def tag( params = {} )

            attr = HTML::AutoAttr.new( params['attr'] || {}, @sorted )

            # emtpy tag
            unless params['cdata'] and params['cdata'].to_s.length
                return '<' + params['tag'] + ' />' + @newline
            end

            cdata = ''
            no_post_indent = 0
            if params['cdata'].kind_of?( Array )

                if params['cdata'][0].kind_of?( Hash )

                    @level += 1
                    cdata = @newline

                    params['cdata'].each do |hash|
                        cdata += tag( hash )
                    end
                    @level -= 1

                else
                    str = ''
                    params['data'].each do |scalar|
                        str += tag( 'tag' => params['tag'], 'attr' => attr, 'cdata' => scalar )
                    end
                    return str
                end

            elsif params['cdata'].kind_of?( Hash )
                @level += 1
                cdata = @newline + tag( params['cdata'] )
                @level -= 1

            else
                # do encoding here
                cdata = params['cdata']
                no_post_indent = 1
            end

            return (@indent * @level)  \
                + '<' + params['tag'] + attr.to_s + '>'  \
                + cdata.to_s + ( no_post_indent ? '' : ( @indent * @level ) )  \
                + '</' + params['tag'] + '>' + @newline

        end

  end

end
