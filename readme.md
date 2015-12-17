HTML-AutoTag (ruby)
===================
Just another HTML tag generator for ruby. [![Gem Version](https://badge.fury.io/rb/HTML-AutoTag.svg)](https://rubygems.org/gems/HTML-AutoTag) [![Build Status](https://api.travis-ci.org/jeffa/html-autotag-ruby.svg?branch=master)](https://travis-ci.org/jeffa/html-autotag-ruby)

Description
-----------
Generate HTML tags with ease (HTML4, HTML5, XHTML and SVG).

Synopsis
--------
```ruby
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
```
Also includes HTML::AutoAttr which provides rotating attributes:
```ruby
require 'HTML/AutoAttr'

attr = HTML::AutoAttr.new( { 'foo' => ['bar','baz','qux'] } )

4.times { puts attr.to_s }
```

Installation
------------
```
gem install HTML-AutoTag
```

License and Copyright
---------------------
See [License](License.md).
