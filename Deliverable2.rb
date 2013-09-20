# Name: Chris Fichman
# Collaborator: Tony Gagliardi
# Assignment: Lab 2: Deliverable
# Description: Various implementations of common CS problems in Ruby

# Part I: Hello World

class HelloWorldClass
	def initialize(name)
		@name = name.capitalize
	end
	
	def sayHi
		puts "Hello #{@name}!"
	end
	
	hello = HelloWorldClass.new("Chris!")
	hello.sayHi
	
end

def palindrome?(string)
	string = (string.gsub(/[^a-zA-Z]/, "")).downcase
	rstring = string.reverse
	
	return (string == rstring)
end
	
puts palindrome?("A man, a plan, a canal -- Panama")
puts palindrome?("Madam, I'm Adam!")                 
puts palindrome?("Abracadabra")


def count_words(string)
	words = ((string.gsub(/[^a-zA-Z\s]/, "")).downcase)
	words = words.split
	freqs = Hash.new(0)
	words.each { |word| freqs[word] += 1 }
	return freqs.to_s

end

puts count_words("A man, a plan, a canal -- Panama")
# => {'a' => 3, 'man' => 1, 'canal' => 1, 'panama' => 1, 'plan' => 1}
puts count_words "Doo bee doo bee doo"
# => {'doo' => 3, 'bee' => 2}

class WrongNumberOfPlayersError < StandardError; end
class NoSuchStrategyError < StandardError; end

def rps_game_winner(game)
	raise WrongNumberOfPlayersError unless game.length == 2
	viable = ["P","S","R"]
	#Help from Tony on this if statment
	if (viable.include?(game[0][1].upcase) && viable.include?(game[1][1].upcase))
		if (game[0][1] + game[1][1] =~ /SS|PP|RR|SP|RS|PR/i)
			game[0]
		else
			game[1]
		end
	else
		raise NoSuchStrategyError
	end
end	

def rps_tournament(tourney)
	if tourney[0][1].is_a? String
		rps_game_winner(tourney)
	else
		rps_game_winner([rps_tournament(tourney[0]), 
					rps_tournament(tourney[1])])
	end
end

input = [ [ [ ["Armando", "P"], ["Dave", "S"] ], [ ["Richard", "R"],  ["Michael", "S"] ],],[ [ ["Allen", "S"], ["Omer", "P"] ], [ ["David E.", "R"], ["Richard X.", "P"] ] ] ]
puts rps_tournament(input)

#Credit to user zippie on stack overflow:
#http://stackoverflow.com/questions/15855480/how-to-sort-array-of-words-into-arrays-of-anagrams-in-ruby

def combine_anagrams(words)
	agram_array={}
	
	words.each do |word|
		agram_array[word.downcase.split('').sort.join] ||=[]
		agram_array[word.downcase.split('').sort.join] << word 
	end
	
	agram_array
end

puts combine_anagrams(['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'])
