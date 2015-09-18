Spreadsheet-HTML (ruby)
=======================
Just another HTML table generator for ruby.

Description
-----------
Generate HTML tables with ease (HTML4, XHTML and HTML5).

Synopsis
--------
```ruby
require 'Spreadsheet/HTML'

generator = Spreadsheet::HTML.new

puts generator.generate( Array[ [1,2,3], [4,5,6] ] )
```

Installation
------------
We are currently pre-Alpha, so installation is not recommended.
Also, bundler and test-unit are required, which is not awesome.

* gem install bundler
* gem install test-unit
* rake test
* rake build
* ~~rake install~~ :skull:

License and Copyright
---------------------
See [License](License.md).
