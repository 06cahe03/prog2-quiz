require "minitest/autorun"
require_relative "../fill_in_blank"

class FillInBlankTest < Minitest::Test
  def test_correct
    q = FillInBlank.new("Ruby skapades av ___", ["Matz", "Yukihiro Matsumoto"])
    assert q.correct?("Matz")
    assert q.correct?("Yukihiro Matsumoto")
  end

  def test_wrong
    q = FillInBlank.new("Ruby skapades av ___", ["Matz", "Yukihiro Matsumoto"])
    refute q.correct?("Hasse")
  end

  def test_answer_single
    q = FillInBlank.new("Ruby skapades av ___", ["Matz"])
    assert_equal q.answer, "Matz"
  end

  def test_answer_two
    q = FillInBlank.new("Ruby skapades av ___", ["Matz", "Yukihiro Matsumoto"])
    assert_equal q.answer, "Matz eller Yukihiro Matsumoto"
  end

  def test_answer_three_or_more
    q = FillInBlank.new("Ruby skapades av ___", ["Matz", "Yukihiro Matsumoto", "Someone else"])
    assert_equal q.answer, "Matz, Yukihiro Matsumoto eller Someone else"

    q = FillInBlank.new("Ruby skapades av ___", ["Matz", "Yukihiro Matsumoto", "Someone else", "Another one"])
    assert_equal q.answer, "Matz, Yukihiro Matsumoto, Someone else eller Another one"
  end
end
