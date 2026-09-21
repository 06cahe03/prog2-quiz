require_relative "question"

class MultipleChoice < Question
  attr_reader :alternatives

  def initialize(prompt, alternatives, answer)
    super(prompt, answer)

    raise ArgumentError, "alternatives must not be empty" if alternatives.empty?
    raise ArgumentError, "alternatives must contain answer" if !alternatives.include?(answer)

    @alternatives = alternatives
  end

  def ask
    puts prompt
    alternatives.each_with_index do |x, i|
      puts "#{i + 1}. #{x}"
    end
    gets.chomp
  end

  def correct?(reply)
    reply.strip.to_i == alternatives.find_index(answer) + 1
  end
end