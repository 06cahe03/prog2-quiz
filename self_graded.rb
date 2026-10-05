require_relative "question"

class SelfGraded < Question
  def ask
    puts @prompt
    puts "Tänk ut svaret och tryck Enter."
    gets.chomp
    puts "Svar: " + @answer
    puts "Hade du rätt? (j/n)"
    gets.chomp
  end

  def correct?(reply)
    reply.strip.downcase == "j"
  end

  def hint(reply)
    nil
  end
end
