require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << [*'A'..'Z'].sample
    end
    @letters
  end

  def score
    @ans = params[:answer]
    @result = if included?(@ans, @letters)
                if en_word?(@ans)
                  "Congratulations! #{@ans} is a valid English word!"
                else
                  "Sorry but #{@ans} does not seem to be a valid English word..."
                end
              else
                "Sorry but #{@ans} can't be built out of #{@letters}"
              end
  end

  def en_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response)
    json['found']
  end

  def included?(word, letters)
    word.upcase.chars.all? { |letter| word.upcase.count(letter) <= letters.count(letter) }
  end
end
