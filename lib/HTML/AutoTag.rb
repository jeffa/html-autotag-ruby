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

== SYNOPSIS

<code>
require 'HTML/AutoTag'
auto = HTML::AutoTag.new

puts auto.tag( 'tag' => 'hr' )
puts auto.tag( 'tag' => 'h1', 'cdata' => 'heading' )
puts auto.tag( 'tag' => 'p', 'cdata' => 'paragraph', 'attr' => { 'class' => 'para' } )

attr = { 'style' => { 'color' => %w{ odd even } } }
puts auto.tag(
    'tag'   => 'ol',
    'attr'  => { 'reversed' => 'reversed' },
    'cdata' => %w{ 1 2 3 4 5 }.map{ |d| { 'tag' => 'li', 'attr' => attr, 'cdata' => d } }
)

tr_attr = { 'class' => %w{ odd even } }
puts auto.tag(
    'tag'   => 'table',
    'attr'  => { 'class' => 'spreadsheet' },
    'cdata' => Array[
        {
            'tag'   => 'tr',
            'attr'  => tr_attr,
            'cdata' => {
                'tag'  => 'th',
                'attr' => { 'style' => { 'color' => %w{ red green } } },
                'cdata' => %w{ one two three },
            },
        },
        {
            'tag'   => 'tr',
            'attr'  => tr_attr,
            'cdata' => {
                'tag'  => 'td',
                'attr' => { 'style' => { 'color' => %w{ green blue } } },
                'cdata' => %w{ four five six },
            },
        },
        {
            'tag'   => 'tr',
            'attr'  => tr_attr,
            'cdata' => {
                'tag'  => 'td',
                'attr' => { 'style' => { 'color' => %w{ red green } } },
                'cdata' => %w{ seven eight nine },
            },
        },
    ]
)
</code>

== DESCRIPTION

Generate nested HTML (HTML4, XHTML and HTML5) tags with custom indentation,
custom encoding and automatic attribute value rotation.

== METHODS

* new

Accepts 4 arguments:

    * encodes

        Endcode HTML entities. (boolean)

    * indent

        Pretty print results. (string)

    * level

        Indentation level to start at. (integer)

    * sorted

        Sort attribute names of the tag alphabetically. (boolean)

* tag

Accepts 3 arguments:

    * tag

        The name of the tag. (string)

    * attr

        Attributes and values for the tag (hash)

    * cdata

        The value wrapped by the tag. Types allowed are:

        * scalar - the string to be wrapped by the tag

        * hash - another tag with its own cdata and attributes

        * array - list of scalars or list of more hashes

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
