require 'spec_helper'

# edge cases with `...-&&...` and `...&&-...` are checked in test_ranges.rb

RSpec.describe('SetIntersection parsing') do
  specify('parse set intersection') do
    root = RP.parse('[a&&z]')
    set = root[0]
    ints = set[0]

    expect(set.count).to eq 1
    expect(ints).to be_instance_of(CharacterSet::Intersection)
    expect(ints.count).to eq 2

    seq1, seq2 = ints.expressions
    expect(seq1).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq1.count).to eq 1
    expect(seq1.first.to_s).to eq 'a'
    expect(seq1.first).to be_instance_of(Literal)
    expect(seq2).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq2.count).to eq 1
    expect(seq2.first.to_s).to eq 'z'
    expect(seq2.first).to be_instance_of(Literal)

    expect(set.matches?('a')).to be false
    expect(set.matches?('&')).to be false
    expect(set.matches?('z')).to be false
  end

  specify('parse set intersection range and subset') do
    root = RP.parse('[a-z&&[^a]]')
    set = root[0]
    ints = set[0]

    expect(set.count).to eq 1
    expect(ints).to be_instance_of(CharacterSet::Intersection)
    expect(ints.count).to eq 2

    seq1, seq2 = ints.expressions
    expect(seq1).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq1.count).to eq 1
    expect(seq1.first.to_s).to eq 'a-z'
    expect(seq1.first).to be_instance_of(CharacterSet::Range)
    expect(seq2).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq2.count).to eq 1
    expect(seq2.first.to_s).to eq '[^a]'
    expect(seq2.first).to be_instance_of(CharacterSet)

    expect(set.matches?('a')).to be false
    expect(set.matches?('&')).to be false
    expect(set.matches?('b')).to be true
  end

  specify('parse set intersection trailing range') do
    root = RP.parse('[a&&a-z]')
    set = root[0]
    ints = set[0]

    expect(set.count).to eq 1
    expect(ints).to be_instance_of(CharacterSet::Intersection)
    expect(ints.count).to eq 2

    seq1, seq2 = ints.expressions
    expect(seq1).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq1.count).to eq 1
    expect(seq1.first.to_s).to eq 'a'
    expect(seq1.first).to be_instance_of(Literal)
    expect(seq2).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq2.count).to eq 1
    expect(seq2.first.to_s).to eq 'a-z'
    expect(seq2.first).to be_instance_of(CharacterSet::Range)

    expect(set.matches?('a')).to be true
    expect(set.matches?('&')).to be false
    expect(set.matches?('b')).to be false
  end

  specify('parse set intersection type') do
    root = RP.parse('[a&&\\w]')
    set = root[0]
    ints = set[0]

    expect(set.count).to eq 1
    expect(ints).to be_instance_of(CharacterSet::Intersection)
    expect(ints.count).to eq 2

    seq1, seq2 = ints.expressions
    expect(seq1).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq1.count).to eq 1
    expect(seq1.first.to_s).to eq 'a'
    expect(seq1.first).to be_instance_of(Literal)
    expect(seq2).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq2.count).to eq 1
    expect(seq2.first.to_s).to eq '\\w'
    expect(seq2.first).to be_instance_of(CharacterType::Word)

    expect(set.matches?('a')).to be true
    expect(set.matches?('&')).to be false
    expect(set.matches?('b')).to be false
  end

  specify('parse set intersection multipart') do
    root = RP.parse('[\\h&&\\w&&efg]')
    set = root[0]
    ints = set[0]

    expect(set.count).to eq 1
    expect(ints).to be_instance_of(CharacterSet::Intersection)
    expect(ints.count).to eq 3

    seq1, seq2, seq3 = ints.expressions
    expect(seq1).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq1.count).to eq 1
    expect(seq1.first.to_s).to eq '\\h'
    expect(seq2).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq2.count).to eq 1
    expect(seq2.first.to_s).to eq '\\w'
    expect(seq3).to be_instance_of(CharacterSet::IntersectedSequence)
    expect(seq3.count).to eq 3
    expect(seq3.to_s).to eq 'efg'

    expect(set.matches?('e')).to be true
    expect(set.matches?('f')).to be true
    expect(set.matches?('a')).to be false
    expect(set.matches?('g')).to be false
  end
end
