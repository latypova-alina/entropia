require_relative "alphabet.rb"
require_relative "entropia.rb"
require_relative "probability.rb"
require_relative "text_info.rb"

russian_alphabet = Alphabet.new
russian_alphabet.add_to_alphabet(('А'..'я').to_a)
russian_alphabet.add_to_alphabet(('0'..'9').to_a)
russian_alphabet.add_to_alphabet(['.', '?', ',', '!', ':', ';', ' ', '"', "\n"].to_a)
russian_alphabet.initialize_symbols_amount

poem = TextInfo.new("Пророк.txt", russian_alphabet)
poem_probability = Probability.new(poem)
poem_entropia = Entropia.new(poem_probability)
puts poem_probability.count_probability
puts poem_entropia.count_entropia

