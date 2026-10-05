require_relative "question"

def to_number(reply)
  reply.strip.gsub(/,/, '.').to_f
end

class NumericQuestion < Question
  def correct?(reply)
    (to_number(reply) - @answer).abs < 0.01
  end

  def hint(reply)
    num = to_number(reply)
    if @answer > num
      puts "Fel. Ledtråd: Svaret är större än #{reply}"
    else
      puts "Fel. Ledtråd: Svaret är mindre än #{reply}"
    end
    gets.chomp
  end
end
