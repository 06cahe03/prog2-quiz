require_relative "question"

class TrueFalse < Question
  def ask
    puts "#{@prompt} (sant/falskt)"
    gets.chomp
  end

  def correct?(reply)
    if @answer
      reply.strip.downcase == "sant"
    else
      reply.strip.downcase == "falskt"
    end
  end

  def answer
    if @answer
      "sant"
    else
      "falskt"
    end
  end

  def hint(reply)
    nil
  end
end
