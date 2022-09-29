require_relative "lib/film"
require_relative "lib/film_collection"

all_films = FilmCollection.from_url_imdb("#{File.dirname(__FILE__)}/data/imdb.html")
puts "Фильм на вечер"
puts
all_directors = all_films.make_directors_list
all_directors.each_with_index { |director, index| puts "#{index + 1}: #{director}" }
puts
puts "Фильм какого режиссера вы хотите сегодня посмотреть?"
input = 0

until input.between?(1, all_directors.length)
  puts
  puts "Пожалуйста, введите число от 1 до #{all_directors.length}"
  puts
  input = Integer(gets) rescue 0
end

puts
puts "И сегодня вечером рекомендую посмотреть:"
puts all_films.make_suitable_films_list(all_directors[input - 1]).sample
