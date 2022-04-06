class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << [*('A'..'Z')].sample
    end
    @letters
  end

  def score; end
end
