require_relative "question"
require_relative "multiple_choice"
require_relative "true_false"
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
      if q.correct?(reply)
        puts "Rätt!"
        @score += 1
      else
        if !q.hint.nil?
          puts "Fel. Ledtråd för första bokstaven: #{q.hint}"
          reply = q.ask
          if q.correct?(reply)
            puts "Rätt!"
            @score += 1
          else
            puts "Fel. Rätt svar: #{q.answer}"
          end
        else
          puts "Fel. Rätt svar: #{q.answer}"
        end
      end
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
  else
    raise ArgumentError, "invalid type for question"    
  end
end

#questions << MultipleChoice.new("Vad heter huvudstaden i Norge?", ["Bergen", "Helsinki", "Oslo"], "Oslo")
#questions << TrueFalse.new("Oslo ligger i Norge", true)

quiz = Quiz.new(questions)

quiz.run
puts "#{quiz.score} av #{quiz.questions.length} rätt."
