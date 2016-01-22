require 'test_helper'

class RegexpTrieTest < Minitest::Test
  def regexp
    RegexpTrie.union("foo", "bar", "baz")
  end

  def test_that_it_has_a_version_number
    refute_nil ::RegexpTrie::VERSION
  end

  def test_union
    assert { regexp === "foo" }
    assert { regexp === "bar" }
    assert { regexp === "baz" }
  end

  def test_instance
    rt = RegexpTrie.new.add("foo").add("bar").add("baz")
    assert { rt.to_regexp == %r/(?:foo|ba[rz])/ }
  end

  def test_prefix_postfix
    re1 = RegexpTrie.union('foo', 'bar', prefix: '\A', postfix: '\Z')
    assert_match re1, 'foo'
    refute_match re1, 'xfoo'
    refute_match re1, 'fooy'

    re2 = RegexpTrie.new.add('foo').to_regexp(prefix: '\A', postfix: '\Z')
    assert_match re2, 'foo'
    refute_match re2, 'xfoo'
    refute_match re2, 'fooy'
  end
end
