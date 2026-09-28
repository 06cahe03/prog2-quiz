require_relative "question"

class NumericQuestion < Question
  def correct?(reply)
    (reply.strip.gsub(/,/, '.').to_f - answer).abs < 0.01
  end

  def hint
    nil
  end
end
