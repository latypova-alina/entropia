class Entropia
  attr_accessor :probability_array, :letter_entropia_sum, :matrix_entropia_sum, :symbols_dependency_matrix

  def initialize(probability)
    @probability_array = probability.char_p_array
    @symbols_dependency_matrix = probability.symbols_dependency_matrix
    @letter_entropia_sum = 0.0
    @matrix_entropia_sum = 0.0
  end

  def count_entropia
    probability_array.each do |p|
      value = p.values.first
      @letter_entropia_sum = @letter_entropia_sum - value * Math.log2(value) unless value == 0.0
    end
    @letter_entropia_sum
  end

  def letter_has_probability?(letter_p)
    probability_array.map{|e| e.keys[0]}.include?(letter_p)
  end

  def letter_probability(letter)
    probability_array.find{|prob| prob[letter]}.values[0]
  end

  def information_countable?(symbol_probability, connected_probability)
    connected_probability != 0.0 && symbol_probability
  end

  def count_dependant_letters_entropia_matrix
    @symbols_dependency_matrix.each_with_index do |element, row, col|
      second_letter = element.keys.first[2]
      symbol_p = letter_probability(second_letter) if letter_has_probability?(second_letter)
      connected_p = element.values[0]
      syllable = element.keys[0]
      conditional_p = connected_p/symbol_p
      if information_countable?(symbol_p, connected_p)
        @symbols_dependency_matrix[row, col][syllable] = connected_p * Math.log2(conditional_p)
      end
      @matrix_entropia_sum = @matrix_entropia_sum - @symbols_dependency_matrix[row, col][syllable]
    end
  end
end
