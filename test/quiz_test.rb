require "minitest/autorun"
require_relative "../quiz"
require_relative "../question"

class QuizTest < Minitest::Test
  def test_counts_its_questions
    quiz = Quiz.new
    quiz.add(Question.new("Vad heter huvudstaden i Norge?", "Oslo"))
    quiz.add(Question.new("Vad svarar 5.class?", "Integer"))
    assert_equal 2, quiz.total
  end

  def test_wrong
    quiz = Quiz.new
    q = Question.new("Vad heter huvudstaden i Norge?", "Oslo")
    assert quiz.wrong?(q, "Bergen")
    refute quiz.wrong?(q, "Oslo")
  end
end
