require_relative "question"
require_relative "multiple_choice"
require_relative "true_false"
require_relative "numeric_question"
require_relative "self_graded"
require "sqlite3"

class Quiz
  attr_reader :score, :questions

  def initialize(questions)
    @questions = questions
    @score = 0
  end

  def run
    questions.each do |q|
      reply = q.ask
      if wrong?(q, reply)
        reply = q.hint
        if wrong?(q, reply)
          puts "Fel. Rätt svar: #{q.answer}"
        end
      end
    end
  end

  def wrong?(q, reply)
    if reply.nil?
      true
    elsif q.correct?(reply)
      puts "Rätt!"
      @score += 1
      false
    else
      true
    end
  end
end

db = SQLite3::Database.new "quiz.db"
questions = db.execute("SELECT * FROM questions").map do |(prompt, answer, type, alternatives)|
  if type == "question"
    Question.new(prompt, answer)
  elsif type == "multiple_choice"
    alts = alternatives.split(",")
    MultipleChoice.new(prompt, alts, answer)
  elsif type == "true_false"
    TrueFalse.new(prompt, answer == "sant")
  elsif type == "numeric_question"
    NumericQuestion.new(prompt, answer.to_f)
  elsif type == "self_graded"
    SelfGraded.new(prompt, answer)
  else
    raise ArgumentError, "invalid type for question"    
  end
end

#questions << MultipleChoice.new("Vad heter huvudstaden i Norge?", ["Bergen", "Helsinki", "Oslo"], "Oslo")
#questions << TrueFalse.new("Oslo ligger i Norge", true)

quiz = Quiz.new(questions)

quiz.run
puts "#{quiz.score} av #{quiz.questions.length} rätt."
