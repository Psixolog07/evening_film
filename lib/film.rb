class Film
  attr_accessor :title, :director, :release_year

  def initialize(parametrs)
    @title = parametrs[:title]
    @director = parametrs[:director]
    @release_year = parametrs[:release_year].to_i
  end

  def to_s
    "#{@director} - #{@title} (#{@release_year})"
  end
end
