require "HTML/AutoTag/version"
require "HTML/AutoAttr"
require "htmlentities"

module HTML

  class AutoTag

        attr_accessor 'encodes', 'indent', 'level', 'sorted', 'newline'

        # params expects the following keys:
        #   * encodes
        #       Endcode HTML entities. (boolean)
        #
        #   * indent
        #       Pretty print results. (string)
        #
        #   * level
        #       Indentation level to start at. (integer)
        #
        #   * sorted
        #
        Sort attribute names of the tag alphabetically. (boolean)
        def initialize( params = {} )
            @encodes    = params['encodes'] ? 1 : 0
            @indent     = params['indent']  || ''
            @level      = params['level']   || 0
            @sorted     = params['sorted']  ? 1 : 0
            @newline    = params['indent']  ? "\n" : ''
            @encoder    = HTMLEntities.new
        end

        # params expects the following keys:
        #
        #   * tag
        #       The name of the tag. (string)
        #
        #   * attr
        #       Attributes and values for the tag (hash)
        #
        #   * cdata
        #       The value wrapped by the tag. Types allowed are:
        #       * scalar - the string to be wrapped by the tag
        #       * hash - another tag with its own cdata and attributes
        #       * array - list of scalars or list of more hashes
        #
        def tag( params = {} )

            if params['attr'].kind_of?( HTML::AutoAttr )
                attr = params['attr']
            else
                attr = HTML::AutoAttr.new( params['attr'] || {}, @sorted )
            end

            # emtpy tag
            unless params['cdata'] and params['cdata'].to_s.length
                return ( @indent * @level ) + '<' + params['tag'] + attr.to_s + ' />' + @newline
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
                    params['cdata'].each do |scalar|
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
                cdata = @encoder.encode( cdata ) if @encodes == 1
                no_post_indent = 1
            end

            return (@indent * @level)  \
                + '<' + params['tag'] + attr.to_s + '>'  \
                + cdata.to_s + ( no_post_indent == 1 ? '' : ( @indent * @level ) )  \
                + '</' + params['tag'] + '>' + @newline

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
