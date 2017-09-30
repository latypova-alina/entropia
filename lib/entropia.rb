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
      @letter_entropia_sum = @letter_entropia_sum + value * Math.log2(value) unless value == 0.0
    end
    -@letter_entropia_sum
  end

  def count_dependant_letters_entropia_matrix
    @symbols_dependency_matrix.each_with_index do |element, row, col|
      @symbols_dependency_matrix[row, col][element.keys[0]] = -(element.values[0] * Math.log2(element.values[0])).round(3) unless element.values[0] == 0.0
      @matrix_entropia_sum = -(@matrix_entropia_sum + @symbols_dependency_matrix[row, col][element.keys[0]])
    end
  end
end
