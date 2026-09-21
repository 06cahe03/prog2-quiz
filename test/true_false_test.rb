require "minitest/autorun"
require_relative "../true_false"

class TrueFalseTest < Minitest::Test
  def test_correct
    q = TrueFalse.new("Oslo ligger i Norge", true)
    assert q.correct?("sant")
  end

  def test_wrong
    q = TrueFalse.new("Oslo ligger i Norge", true)
    refute q.correct?("falskt")
  end

  def test_invalid
    q = TrueFalse.new("Oslo ligger i Norge", true)
    refute q.correct?("banan")
  end
end
