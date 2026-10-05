require_relative "question"
require_relative "multiple_choice"
require_relative "true_false"
require_relative "numeric_question"
require_relative "self_graded"
require_relative "quiz"
require_relative "fill_in_blank"
require "sqlite3"

quiz = Quiz.new
db = SQLite3::Database.new "quiz.db"
db.execute("SELECT * FROM questions").each do |(prompt, answer, type, alternatives)|
  if type == "question"
    quiz.add(Question.new(prompt, answer))
  elsif type == "multiple_choice"
    alts = alternatives.split(",")
    quiz.add(MultipleChoice.new(prompt, alts, answer))
  elsif type == "true_false"
    quiz.add(TrueFalse.new(prompt, answer == "sant"))
  elsif type == "numeric_question"
    num = answer.to_f
    quiz.add(NumericQuestion.new(prompt, num))
  elsif type == "self_graded"
    quiz.add(SelfGraded.new(prompt, answer))
  elsif type == "fill_in_blank"
    answers = answer.split(",")
    quiz.add(FillInBlank.new(prompt, answers))
  else
    raise ArgumentError, "invalid type for question"    
  end
end

quiz.run
puts "#{quiz.score} av #{quiz.total} rätt."
