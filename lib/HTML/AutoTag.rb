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

            attr = HTML::AutoAttr.new( params['attr'], @sorted )
            # emtpy tag
            if defined?( params['cdata'] ) != nil
                return '<' + params['tag'] + ' />' + @newline
            end

            if params['cdata'].kind_of?( Array )

                if params['cdata'][0].kind_of?( Hash )

                else

                end

            elsif params['cdata'].kind_of?( Hash )

            else

            end

        end

  end

end
