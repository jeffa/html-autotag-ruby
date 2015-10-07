HTML-AutoTag (ruby)
===================
Just another HTML tag generator for ruby. [![Gem Version](https://badge.fury.io/rb/HTML-AutoTag.svg)](https://badge.fury.io/rb/HTML-AutoTag)

Description
-----------
Generate HTML tags with ease (HTML4, HTML5, XHTML and SVG).

Synopsis
--------
```ruby
require 'HTML/AutoTag'

auto = HTML::AutoTag.new

puts auto.tag( 'tag' => 'p', 'cdata' => 'a paragraph' )
```

Installation
------------
We are currently pre-Alpha, so installation is not recommended.

* rake test
* rake build
* ~~rake install~~ :skull:

License and Copyright
---------------------
See [License](License.md).
