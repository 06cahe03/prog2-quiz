class Question
  attr_reader :prompt, :answer

  def initialize(prompt, answer)
    raise ArgumentError, "prompt must not be empty" if prompt.empty?
    raise ArgumentError, "answer must not be empty" if answer.to_s.empty?

    @prompt = prompt
    @answer = answer
  end

  def ask
    puts prompt
    gets.chomp
  end

  def correct?(reply)
    reply.strip.downcase == answer.downcase
  end

  def to_s
    "#{prompt} (#{answer})"
  end

  def hint
    puts "Fel. Ledtråd för första bokstaven: #{answer[0]}"
    gets.chomp
  end
end
