require "pry-rails"
class Probability
  attr_accessor :text_info, :char_p_array, :symbols_dependency_matrix, :three_letters, :three_letters_p

  def initialize(text_info)
    @text_info = text_info
    @char_count = text_info.char_count
    @char_p_array = []
    @symbols_dependency_matrix = text_info.symbols_dependency_matrix
    @three_letters = text_info.three_letters
    @three_letters_p = {}
    prepare_probability_array
  end

  def prepare_probability_array
    text_info.alphabet.each_with_index do |char, index|
      char_p_array[index] = { "#{char}" => 0.0 }
    end
  end

  def count_probability
    alphabet = text_info.alphabet
    symbols_amount = text_info.symbols_amount_array
    char_count = text_info.char_count
    File.open(text_info.file, "r") do |file|
      file.each_char do |c|
        char_p_array[alphabet.index(c)][c] = symbols_amount[alphabet.index(c)][c] / char_count if alphabet.include?(c)
      end
    end
  end

  def count_dependant_letters_probability
    @symbols_dependency_matrix.each_with_index do |element, row, col|
      @symbols_dependency_matrix[row, col][element.keys[0]] = element.values[0]/(text_info.char_count-1)
    end
  end

  def count_three_dependant_letters_probability
    binding.pry
    @three_letters.keys.each{ |key| @three_letters_p[key] = @three_letters[key]/@char_count }
    @three_letters_p
  end
end
