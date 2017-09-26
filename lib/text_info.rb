class TextInfo
  attr_accessor :file, :alphabet, :char_count, :symbols_amount_array

  def initialize(file, alphabet)
    @file = file
    @alphabet = alphabet.symbols
    @char_count = 0.0
    @symbols_amount_array = alphabet.symbols_amount_array
    prepare_chars_info
  end

  def prepare_chars_info
    File.open("Пророк.txt", "r") do |file|
      file.each_char do |c|
        @char_count += 1.0
        symbols_amount_array[alphabet.index(c)][c] += 1.0
      end
    end
  end
end
