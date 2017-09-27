require_relative "alphabet.rb"
require_relative "entropia.rb"
require_relative "probability.rb"
require_relative "text_info.rb"
require "matrix.rb"

class Matrix
  def []=(row, col, x)
    @rows[row][col] = x
  end
end

russian_alphabet = Alphabet.new
russian_alphabet.add_to_alphabet(('А'..'я').to_a)
russian_alphabet.add_to_alphabet(('0'..'9').to_a)
russian_alphabet.add_to_alphabet(['.', '?', ',', '!', ':', ';', ' ', '"', "\n"].to_a)
russian_alphabet.initialize_symbols_amount

poem = TextInfo.new("Пророк.txt", russian_alphabet)
poem_probability = Probability.new(poem)
poem_entropia = Entropia.new(poem_probability)
poem.prepare_dependency_matrix
poem.count_dependant_letters_amount
poem_probability.count_dependant_letters_probability
poem_probability.symbols_dependency_matrix.each do |element|
  puts element if element.values[0] > 0.0
end
poem_entropia.count_dependant_letters_entropia_matrix
poem_entropia.symbols_dependency_matrix.each do |element|
  puts element if element.values[0] != 0.0
end
puts poem_probability.count_probability
puts poem_entropia.count_entropia

