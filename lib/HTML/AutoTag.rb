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
            @sorted     = params['sorted']  || 0
            @newline    = params['indent'] ? "\n" : ''
            @encoder    = HTMLEntities.new
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
                cdata = params['cdata']
                @encoder.encode( cdata ) if @encodes == 1
                no_post_indent = 1
            end

            return (@indent * @level)  \
                + '<' + params['tag'] + attr.to_s + '>'  \
                + cdata.to_s + ( no_post_indent ? '' : ( @indent * @level ) )  \
                + '</' + params['tag'] + '>' + @newline

        end

  end

end

=begin rdoc

= NAME

HTML::AutoTag - Just another HTML tag generator.

== SYNOPSIS

<code>
require 'HTML/AutoTag'
tag = HTML::AutoTag.new

puts auto.tag( 'tag' => 'p', 'cdata' => 'paragraph' )
</code>

== DESCRIPTION

Generate nested HTML (HTML4, XHTML and HTML5) tags with custom indentation,
custom encoding and automatic attribute value rotation.

== SEE ALSO

* ttp://www.w3.org/TR/html5/syntax.html

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
