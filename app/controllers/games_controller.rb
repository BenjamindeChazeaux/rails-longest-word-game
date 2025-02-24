class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  GRID_SIZE = 10  # Constante pour la taille de la grille

  def new
    @letters = generate_random_letters
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split(',')
    @score = 0

    # Vérifier si le mot peut être créé à partir de la grille
    unless can_build_word?(@word, @letters.dup)
      @result = "Sorry but '#{@word}' can't be built out of #{@letters.join(', ')}"
      return
    end

    # Vérifier si le mot existe dans le dictionnaire
    url = "https://dictionary.lewagon.com/#{@word}"
    word_found = JSON.parse(URI.open(url).read)["found"] rescue false
    
    if word_found
      @score = @word.length
      @result = "Congratulations! '#{@word}' is a valid English word!"
    else
      @result = "Sorry but '#{@word}' does not seem to be a valid English word..."
    end
  end

  private

  def generate_random_letters
    Array.new(GRID_SIZE) { ('A'..'Z').to_a.sample }
  end

  def can_build_word?(word, letters)
    word.chars.all? do |letter|
      if index = letters.index(letter)
        letters.delete_at(index)
        true
      else
        false
      end
    end
  end

  # def calculate_score
  #   if !valid_word?(@word, @grid)
  #     @result = "Sorry but '#{@word}' can't be built out of #{@grid.join(', ')}"
  #     return 0
  #   end

  #   if !english_word?(@word)
  #     @result = "Sorry but '#{@word}' does not seem to be a valid English word..."
  #     return 0
  #   end

  #   @result = "Congratulations '#{@word}' is a valid word."
  #   @word.length
  # end

  # def valid_word?(word, grid)
  #   word.chars.all? { |char| word.count(char) <= grid.count(char) }
  # end

end 
