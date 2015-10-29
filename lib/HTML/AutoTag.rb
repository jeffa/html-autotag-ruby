require "HTML/AutoTag/version"
require "HTML/AutoAttr"
require "htmlentities"

module HTML

  class AutoTag

        attr_accessor 'encodes', 'indent', 'level', 'sorted', 'newline'

        def initialize( params = {} )
            @encodes    = params['encodes'] ? 1 : 0
            @indent     = params['indent']  || ''
            @level      = params['level']   || 0
            @sorted     = params['sorted']  ? 1 : 0
            @newline    = params['indent']  ? "\n" : ''
            @encoder    = HTMLEntities.new
        end

        def tag( params = {} )

            # TODO: make these method args
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
                        rendered += tag( hash )
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
                rendered = @newline + tag( cdata )
                @level -= 1

            else
                rendered = cdata
                rendered = @encoder.encode( rendered ) if @encodes == 1
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

= NAME

HTML::AutoTag - Just another HTML tag generator.

== DESCRIPTION

Generate nested HTML (HTML4, XHTML and HTML5) tags with custom indentation,
custom encoding and automatic attribute value rotation.

== SEE ALSO

* http://www.w3.org/TR/html5/syntax.html

== GITHUB

The Github project is https://github.com/jeffa/html-autotag-ruby

== SUPPORT

You can find documentation for this module with the ri command.

ri HTML::AutoTag

== AUTHOR

Jeff Anderson, <jeffa at cpan.org>

== LICENSE AND COPYRIGHT

Copyright 2015 Jeff Anderson. (See License.md shipped with distro)

=end
