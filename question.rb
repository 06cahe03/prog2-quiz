class Question
  attr_reader :prompt, :answer

  def initialize(prompt, answer)
    if prompt.empty?
      raise ArgumentError, "prompt must not be empty"
    end
    if answer.empty?
      raise ArgumentError, "answer must not be empty"
    end

    @prompt = prompt
    @answer = answer
  end

  #def prompt
  #  @prompt
  #end

  #def answer
  #  @answer
  #end

  #def answer=(new_answer)
  #  @answer = new_answer
  #end

  #def ask
  #  puts prompt
  #  gets.chomp
  #end

  def correct?(reply)
    reply.strip.downcase == answer.downcase
  end

  def to_s
    "#{prompt} (#{answer})"
  end

  def hint
    answer[0]
  end
end
