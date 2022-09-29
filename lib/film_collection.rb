require "open-uri"
require "nokogiri"
require_relative "film"

class FilmCollection

  URL_IMDB = "https://www.imdb.com/chart/top?pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=470df400-70d9-4f35-bb05-8646a1195842&pf_rd_r=17NKWQ21B3FWWB8Z0XGT&pf_rd_s=right-4&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_ql_3"
  
  def self.from_data_html_imdb(doc)
    films = doc.css("td[class='titleColumn']").map do |film| 
      title = film.css("a").text
      director = film.css("a/@title").text.split(" (")[0]
      release_year = film.css("span").text.scan(/\d{4}/)[0]
      Film.new(title: title, director: director, release_year: release_year)
    end

    new(films)
  end

  def self.from_url_imdb(list_path)
    begin
      uri = URI.open(URL_IMDB)
      doc = Nokogiri::HTML(uri)
      films = from_data_html_imdb(doc)
      File.open(list_path, "w") { |f| f.write(doc) }
      return films
    rescue
      doc = File.open(list_path, "r") { |f| Nokogiri::HTML(f) }
      from_data_html_imdb(doc)
    end
  end

  def initialize (films = [])
    @films = films
  end

  def make_directors_list
    @films.map(&:director).uniq
  end

  def make_suitable_films_list(director)
    @films.select { |film| film.director == director }
  end
end
