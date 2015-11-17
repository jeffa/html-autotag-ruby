require "HTML/AutoTag/version"
require "HTML/AutoAttr"
require "HTML/Encoder"

module HTML

  class AutoTag

        attr_accessor 'encode', 'encodes', 'indent', 'level', 'sorted', 'newline'

        # Defaults to empty string which produces no encoding.

        def initialize( params = {} )
            @encodes    = params['encodes']
            @encode     = params['encode']  || !@encodes.nil?
            @indent     = params['indent']  || ''
            @level      = params['level']   || 0
            @sorted     = params['sorted']  ? 1 : 0
            @newline    = params['indent']  ? "\n" : ''
            @encoder    = HTML::Encoder.new
        end

        def tag( params )

            # TODO: make these method args if possible
            tag   = params['tag']
            attr  = params['attr']
            cdata = params['cdata']

            unless attr.kind_of?( HTML::AutoAttr )
                attr = HTML::AutoAttr.new( attr, @sorted )
            end

            # emtpy tag
            unless cdata and cdata.to_s.length
                return ( @indent * @level ) + '<' + tag + attr.to_s + ' />' + @newline
            end

            rendered       = ''
            no_post_indent = 0

            if cdata.kind_of?( Array )

                if cdata[0].kind_of?( Hash )
                    @level += 1
                    rendered = @newline

                    cdata.each do |hash|
                        rendered += tag( 'tag' => hash['tag'], 'attr' => hash['attr'], 'cdata' => hash['cdata'] )
                    end
                    @level -= 1
                else
                    str = ''
                    cdata.each do |scalar|
                        str += tag( 'tag' => tag, 'attr' => attr, 'cdata' => scalar )
                    end
                    return str
                end

            elsif cdata.kind_of?( Hash )
                @level += 1
                rendered = @newline + tag( 'tag' => cdata['tag'], 'attr' => cdata['attr'], 'cdata' => cdata['cdata'] )
                @level -= 1

            else
                rendered = @encode ? @encoder.encode( cdata, @encodes ) : cdata
                no_post_indent = 1
            end

            return (@indent * @level)  \
                + '<' + tag + attr.to_s + '>'  \
                + rendered.to_s + ( no_post_indent == 1 ? '' : ( @indent * @level ) )  \
                + '</' + tag + '>' + @newline

        end

  end

end

=begin rdoc

== AUTHOR

Jeff Anderson, <jeffa at cpan.org>

== LICENSE AND COPYRIGHT

Copyright 2015 Jeff Anderson. (See License.md shipped with distro)

=end
