require "test/unit"
require "HTML/AutoTag"

class TestTagAttrs < Test::Unit::TestCase

    def test_simple
        auto = HTML::AutoTag.new()

        assert_equal(
            '<p class="paragraph" />',
            auto.tag( 'tag' => 'p', 'attr' => { 'class' => 'paragraph' } ),
            'empty paragraph tag correct'
        )

        assert_equal(
            '<p class="paragraph">0</p>',
            auto.tag( 'tag' => 'p', 'attr' => { 'class' => 'paragraph' }, 'cdata' => 0 ),
            'paragraph tag correct'
        )

    end

    def test_one_nested
        auto = HTML::AutoTag.new()
        data = %w{ one two three }
        attr = { 'style' => { 'color' => %w{ red green } } }

        html = auto.tag(
            'tag'   => 'ol',
            'attr'  => { 'reversed' => 'reversed' },
            'cdata' => data.map{ |d| { 'tag' => 'li', 'attr' => attr, 'cdata' => d } }
        )

        assert_equal(
            '<ol reversed="reversed"><li style="color: red;">one</li><li style="color: green;">two</li><li style="color: red;">three</li></ol>',
            html,
            'one nested level tags correct'
        )

    end

    def test_two_nested
        auto     = HTML::AutoTag.new()
        data     = %w{ one two three }
        tr_attr  = { 'class' =>  %w{ odd even } }
        td_attr1 = { 'style' => { 'color' => %w{ red green } } }
        td_attr2 = { 'style' => { 'color' => %w{ green blue } } }

        html = auto.tag(
            'tag'   => 'table',
            'attr'  => { 'class' => 'spreadsheet' },
            'cdata' => Array[
                {
                    'tag'   => 'tr',
                    'attr'  => tr_attr,
                    'cdata' => data.map{ |d| { 'tag' => 'th', 'attr' => td_attr1, 'cdata' => d } }
                },
                {
                    'tag'   => 'tr',
                    'attr'  => tr_attr,
                    'cdata' => data.map{ |d| { 'tag' => 'td', 'attr' => td_attr2, 'cdata' => d } }
                },
                {
                    'tag'   => 'tr',
                    'attr'  => tr_attr,
                    'cdata' => data.map{ |d| { 'tag' => 'td', 'attr' => td_attr1, 'cdata' => d } }
                },
            ]
        )

        assert_equal(
            '<table class="spreadsheet"><tr class="odd"><th style="color: red;">one</th><th style="color: green;">two</th><th style="color: red;">three</th></tr><tr class="even"><td style="color: green;">one</td><td style="color: blue;">two</td><td style="color: green;">three</td></tr><tr class="odd"><td style="color: green;">one</td><td style="color: red;">two</td><td style="color: green;">three</td></tr></table>',
            html,
            'two nested level tags correct'
        )

        tr_attr  = { 'class' =>  %w{ odd even } }
        html = auto.tag(
            'tag'   => 'table',
            'attr'  => { 'class' => 'spreadsheet' },
            'cdata' => Array[
                {
                    'tag'   => 'tr',
                    'attr'  => tr_attr,
                    'cdata' => {
                        'tag'  => 'th',
                        'attr' => { 'style' => { 'color' => %w{ red green } } },
                        'cdata' => data,
                    },
                },
                {
                    'tag'   => 'tr',
                    'attr'  => tr_attr,
                    'cdata' => {
                        'tag'  => 'td',
                        'attr' => { 'style' => { 'color' => %w{ green blue } } },
                        'cdata' => data,
                    },
                },
                {
                    'tag'   => 'tr',
                    'attr'  => tr_attr,
                    'cdata' => {
                        'tag'  => 'td',
                        'attr' => { 'style' => { 'color' => %w{ red green } } },
                        'cdata' => data,
                    },
                },
            ]
        )

        assert_equal(
            '<table class="spreadsheet"><tr class="odd"><th style="color: red;">one</th><th style="color: green;">two</th><th style="color: red;">three</th></tr><tr class="even"><td style="color: green;">one</td><td style="color: blue;">two</td><td style="color: green;">three</td></tr><tr class="odd"><td style="color: red;">one</td><td style="color: green;">two</td><td style="color: red;">three</td></tr></table>',
            html,
            'two nested level tags correct - inlined attrs'
        )

    end

end
