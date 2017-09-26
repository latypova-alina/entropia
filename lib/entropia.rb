class Entropia
  attr_accessor :probability_array, :sum

  def initialize(probability)
    @probability_array = probability.char_p_array
    @sum = 0.0
  end

  def count_entropia
    probability_array.each do |p|
      value = p.values.first
      @sum = @sum + value * Math.log2(value) unless value == 0.0
    end
    -@sum
  end
end
