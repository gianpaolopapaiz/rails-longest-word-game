class GamesController < ApplicationController
	def new
		@letters = []
		10.times do 
			@letters << ('a'..'z').to_a.sample
		end
	end

	def word_in_grid?
		word = true
		@attempt.downcase.chars.map do |char|
		@grid.index(char) ? @grid[@grid.index(char)] = "-" : word = false
	end
		
		word
	end

	def score
		@attempt = params[:attempt]
		@grid = params[:grid].split(' ')
		url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
		data = URI.open(url).read
		word_validation = JSON.parse(data)["found"]
		if word_in_grid?() == false
			@result = "Sorry but #{@attempt} can't be built out of #{@grid}"
		elsif word_validation
			@result = "Congratulations! #{@attempt} is a valid English word"
			@points = @attempt.chars.length
			@total_points = @points
		else
			@result = "Sorry but #{@attempt} does not seem to be a valid english word..."
		end
	end
end

# def run_game(attempt, grid, start_time, end_time)
#   # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
#   url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
#   data = URI.open(url).read
#   word_validation = JSON.parse(data)["found"]
#   if word_in_grid?(attempt, grid) == false
#     { score: 0, message: "not in the grid", time: "Invalid" }
#   elsif word_validation
#     { score: attempt.upcase.size - (end_time - start_time), message: "Well done!", time: (end_time - start_time) }
#   else
#     { score: 0, message: "not an english word", time: "Invalid" }
#   end
# end
