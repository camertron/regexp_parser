require "test/unit"
require File.expand_path("../../lib/regexp_parser.rb", __FILE__)

RP = Regexp::Parser

class TestRegexpParserProperties < Test::Unit::TestCase

  types = %w{p P}
  tests = [:alnum, :alpha, :any, :ascii, :blank, :cntrl, :digit, :graph,
           :lower, :print, :punct, :space, :upper, :word, :xdigit]

  types.each do |type|
    token_type = type == 'p' ? :property : :inverted_property

    tests.each do |property|
      define_method "test_parse_#{token_type}_#{property}" do
        t = RP.parse("ab\\#{type}{#{property.to_s.capitalize}}")

        assert( t.expressions.last.is_a?(RP::Expression::CharacterProperty::Base),
               "Expected property, but got #{t.expressions.last.class.name}")

        assert_equal( token_type, t.expressions.last.type )
        assert_equal( property,   t.expressions.last.token )
      end
    end
  end
end
