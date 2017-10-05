require_relative "alphabet.rb"
require_relative "entropia.rb"
require_relative "probability.rb"
require_relative "text_info.rb"
require_relative "public_post.rb"
require "matrix.rb"
require "csv"

PUBLICS =
[{"TI_NA_PONTAH" => "-36166073"},
{"ART_OR_BULLSHIT" => "-33334108"},
{"Batrachospermum" => "-85330"},
{"BRAT_TOLKO_DERJIS" => "-32194500"},
{"DIANA_SHURIGINA" => "-140892492"},
{"GOOGLE_ZAPROSY" => "-91421416"},
{"LENTACH" => "-29534144"},
{"MMMM_VKUSNYATINA" => "-72133851"},
{"NE_MY_TAKIE" => "-34378420"},
{"OBNULYAY" => "-33339790"},
{"PERESKAZANO" => "-79419972"},
{"PIKABU" => "-31480508"},
{"PODSLUSHANO" => "-34215577"},
{"THIN_QUEEN" => "-64403009"},
{"U_NAS_SVOY_RAY" => "-49272117"},
{"DAVID_BOWIE" => "-23731215"},
{"HORROR_STORIES" => "-40529013"}]


class Matrix
  def []=(row, col, x)
    @rows[row][col] = x
  end
end

def russian_alphabet
  russian_alphabet = Alphabet.new
  russian_alphabet.add_to_alphabet(('А'..'я').to_a)
  russian_alphabet.add_to_alphabet(('0'..'9').to_a)
  russian_alphabet.add_to_alphabet(['.', '?', ',', '!', ':', ';', ' ', '"', "\n", ")",
   "(", ">", "<", "@", "*", "%", "#", "[", "]"].to_a)
  russian_alphabet
end

def write_to_file(heading, text)
  open('file.txt', 'a') { |f|
    f << "\n#{heading}\n\n"
    text.each do |element|
      f << "#{element}\n" unless element.values[0] == 0.0
    end
  }
end

def write_matrix_to_file(heading, text)
  open('file.txt', 'a') { |f|
    f << "\n#{heading}\n\n"
    for i in 0...text.row_count
      text.row(i).each do |e|
        f << "#{e} "
      end
      f << "\n"
    end
  }
end

def write_shortened_version(heading, amount, entropia)
  open('shortened_file.txt', 'a'){|f|
    f << "\n#{heading}\nКоличество букв: #{amount}\nЭнтропия: #{entropia}\n\n"
  }
end

def letters_amount(alphabet, poem)
  poem.prepare_chars_info
  poem.symbols_amount_array
end

R_A = russian_alphabet
R_A.initialize_symbols_amount

def count(source)
  text = TextInfo.new(source, R_A)
  open('file.txt', 'a') { |f| f << "\n\n#{source}\n\n" }
  write_to_file("КОЛИЧЕСТВО БУКВ:", letters_amount(R_A, text))
  open('file.txt', 'a') { |f| f << "\n\nВСЕГО БУКВ: #{text.char_count}\n\n" }
  text_probability = Probability.new(text)
  text_probability.count_probability
  text_probability.char_p_array
  write_to_file("ВЕРОЯТНОСТЬ", text_probability.char_p_array)
  text.prepare_dependency_matrix
  text.count_dependant_letters_amount
  #write_matrix_to_file("КОЛИЧЕСТВО ЗАВИСИМЫХ БУКОВОК", poem.symbols_dependency_matrix)
  write_to_file("КОЛИЧЕСТВО ЗАВИСИМЫХ БУКВ", text.symbols_dependency_matrix)
  text_probability.count_dependant_letters_probability
  #write_matrix_to_file("ВЕРОЯТНОСТЬ ЗАВИСИМЫХ БУКОВОК", p_matrix.symbols_dependency_matrix)
  write_to_file("ВЕРОЯТНОСТЬ ЗАВИСИМЫХ БУКВ", text_probability.symbols_dependency_matrix)
  e_matrix = Entropia.new(text_probability)
  e_matrix.count_dependant_letters_entropia_matrix
  open('file.txt', 'a') { |f| f << "\n\ЭНТРОПИЯ: #{e_matrix.count_entropia}\n\n" }
  write_to_file("ЭНТРОПИЯ ЗАВИСИМЫХ БУКВ", e_matrix.symbols_dependency_matrix)
  #write_matrix_to_file("ЭНТРОПИЯ ЗАВИСИМЫХ БУКОВОК", p_matrix.symbols_dependency_matrix)
  open('file.txt', 'a') { |f| f << "\n\nЭНТРОПИЯ: #{e_matrix.matrix_entropia_sum}\n\n" }
  write_shortened_version(source, text.char_count, e_matrix.matrix_entropia_sum)
end

PUBLICS.each do |public|
  p = PublicPost.new()
  p.posts(public.values[0])
  File.open("#{public.keys[0]}.txt", "w") {|f| f.write(p.posts_texts) }
  count("#{public.keys[0]}.txt")
end



