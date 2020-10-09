require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10){("A".."Z").to_a[rand(26)]}
  end
  def score
    @input = params["word"]
    guess = @input.upcase.split("")
    boolean = guess.all? { |letter| params[:qualquer].include? letter }
    if boolean == false
      @answer = "Sorry, #{@input} do not match the size"
    end
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    response_serialized = open(url).read
    data_from_api = JSON.parse(response_serialized)
    if data_from_api["found"] == false
      @answer = "#{@input} is Not an english word"
    else
      @answer = "Congrats, #{@input} is an english word"
    end
  end
end
