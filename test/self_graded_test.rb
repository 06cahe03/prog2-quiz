require "minitest/autorun"
require_relative "../self_graded"

class SelfGradedTest < Minitest::Test
  def test_correct
    q = SelfGraded.new("Testing fråga", "Testing svar")
    assert q.correct?("j")
    refute q.correct?("n")
  end
end
