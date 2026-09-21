require "minitest/autorun"
require_relative "../multiple_choice"

class MultipleChoiceTest < Minitest::Test
  def test_correct
    q = MultipleChoice.new("Vad heter huvudstaden i Norge?", ["Bergen", "Helsinki", "Oslo"], "Oslo")
    assert q.correct?("3")
  end

  def test_wrong
    q = MultipleChoice.new("Vad heter huvudstaden i Norge?", ["Bergen", "Helsinki", "Oslo"], "Oslo")
    refute q.correct?("1")
  end

  def test_wrong_out_of_range
    q = MultipleChoice.new("Vad heter huvudstaden i Norge?", ["Bergen", "Helsinki", "Oslo"], "Oslo")
    refute q.correct?("5")
  end

  def test_refuses_answer_not_in_alternatives
    assert_raises(ArgumentError) { Question.new("Test", ["Svar 1", "Svar 2"], "Svar 3") }
  end
end
