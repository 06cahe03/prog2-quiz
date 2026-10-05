require_relative "question"

def array_to_swedish(arr, seperator)
  # workaround för ett element, annars får man " eller {x}"
  if arr.length < 2
    arr[0]
  else
    "#{arr[0..-2].join(", ")} #{seperator} #{arr[-1]}"
  end
end

class FillInBlank < Question
  def correct?(reply)
    arr = @answer.map {|x| x.downcase}
    arr.include?(reply.strip.downcase)
  end

  def hint(reply)
    arr = @answer.map {|x| x[0]}
    puts "Fel. Ledtråd för första bokstäverna: #{array_to_swedish(arr, "och")}"
    gets.chomp
  end

  def answer
    array_to_swedish(@answer, "eller")
  end
end
