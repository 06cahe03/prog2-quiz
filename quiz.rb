require_relative "question"

class Quiz
  attr_reader :score

  def initialize
    @questions = []
    @score = 0
  end

  def add(question)
    @questions << question
  end

  def total
    @questions.length
  end

  def run
    @questions.each do |q|
      reply = q.ask
      if wrong?(q, reply)
        reply = q.hint(reply)
        if wrong?(q, reply)
          puts "Fel. Rätt svar: #{q.answer}"
        end
      end
    end
  end

  def wrong?(q, reply)
    if !reply.nil? && q.correct?(reply)
      puts "Rätt!"
      @score += 1
      false
    else
      true
    end
  end
end
