require_relative "question"
require "sqlite3"

class Quiz
  attr_reader :score, :questions

  def initialize(questions)
    @questions = questions
    @score = 0
  end

  def run
    questions.each do |q|
      puts q.prompt

      i = 0
      while i < 2
        reply = gets.chomp

        if q.correct?(reply)
          puts "Rätt!"
          @score += 1
          break
        else
          if i == 0
            puts "Fel. Ledtråd för första bokstaven: #{q.hint}"
          else
            puts "Fel. Rätt svar: #{q.answer}"
          end
        end

        i += 1
      end
    end
  end
end

db = SQLite3::Database.new "quiz.db"
questions = db.execute("SELECT * FROM questions").map do |(p, a)|
  Question.new(p, a)
end

quiz = Quiz.new(questions)

quiz.run
puts "#{quiz.score} av #{quiz.questions.length} rätt."
