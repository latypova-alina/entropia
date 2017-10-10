class TextInfo
  attr_accessor :file, :alphabet, :char_count, :symbols_amount_array, :symbols_dependency_matrix, :three_letters

  def initialize(file, alphabet)
    @file = file
    @alphabet = alphabet.symbols
    @char_count = 0.0
    @symbols_amount_array = alphabet.symbols_amount_array
    @symbols_dependency_matrix = Matrix.build(@alphabet.length){0}
    @three_letters = {}
    @three_letters_p = {}
    prepare_chars_info
  end

  def prepare_chars_info
    File.open(file, "r") do |file|
      file.each_char do |c|
        @char_count += 1.0
        symbols_amount_array[alphabet.index(c)][c] += 1.0 if alphabet.include?(c)
      end
    end
  end

  def prepare_dependency_matrix
    @symbols_dependency_matrix.each_with_index.each do |element, row, col|
      alphabet.each do |letter|
        @symbols_dependency_matrix[row, col] = {"#{alphabet[col]}_#{alphabet[row]}" => 0.0}
      end
    end
  end

  def count_dependant_letters_amount
    File.open(file, "r") do |file|
      file.each_line do |line|
        for i in 0...(line.length - 1)
          two_letters = [line[i], line[i+1]]
          @symbols_dependency_matrix.each_with_index do |element, row, col|
            regex = "#{two_letters[0]}_#{two_letters[1]}"
            if element.keys[0] == regex
              @symbols_dependency_matrix[row, col][regex] += 1.0
            end
          end
        end
      end
    end
  end

  def count_three_dependant_letters
    @three_letters = {}
    File.open(file, "r") do |file|
      file.each_line do |line|
        for i in 0...(line.length - 2)
          three_chars = [line[i], line[i+1], line[i+2]]
          regex = "#{three_chars[0]}_#{three_chars[1]}_#{three_chars[2]}"
          if @three_letters[regex]
            @three_letters[regex] += 1.0
          else
            @three_letters[regex] = 1.0
          end
        end
      end
    end
    @three_letters
  end
end
