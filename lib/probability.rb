require "pry-rails"
class Probability
  attr_accessor :text_info, :char_p_array

  def initialize(text_info)
    @text_info = text_info
    @char_p_array = []
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
        char_p_array[alphabet.index(c)][c] = (symbols_amount[alphabet.index(c)][c] / char_count).round(5)
      end
    end
    char_p_array
  end
end
