require "HTML/AutoTag/version"

module HTML

  class AutoTag

        attr_accessor 'encodes', 'indent', 'level', 'newline'

        def initialize( params = {} )
            @encodes    = params['encodes'] || ''
            @indent     = params['indent']  || ''
            @level      = params['level']   || 0
            @newline    = defined?( params['indent'] ) == nil ? "\n" : ''

        end

        def tag( params = {} )
            @tag    = params['encodes']
            @cdata  = params['indent']
            @attr   = params['newline']

            # emtpy tag
            if defined?( params['cdata'] ) != nil
                return '<' + params['tag'] + ' />' + @newline
            end

        end

  end

end
