#Name: Chris Fichman
#Program: Assign2.rb
#Email: chris.fichman@gmail.com
#Last Edit: 9/24/2013
#Collaborator: Tony Gagliardi

# PART 0: RPS Tourney
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

# PART I: Classes

class Dessert
	def initialize(name, calories)
		@name = name
		@calories = calories
	end
	
	def healthy?
		if @calories < 200
			true
		else
			false
		end
	end
	
	def delicious?
		true
	end
end

d1 = Dessert.new("Cake", 400)
puts d1.healthy?.to_s
puts d1.delicious?.to_s

class JellyBean < Dessert
	def initialize(name, calories, flavor)
		@name = name
		@calories = calories
		@flavor = flavor
	end
	
	def delicious?
		if @flavor.to_s.downcase == "black licorice"
			false
		else
			true
		end
	end
end
  
# Tests

b1 = JellyBean.new("Bean", 4, "black licorice")
b2 = JellyBean.new("Bean", 4, "Strawberry")

puts "Is a black licorice healthy?"
puts b1.healthy?.to_s
puts "Is black licorice tasty?"
puts b1.delicious?.to_s
puts "Is strawberry healthy?"
puts b2.healthy?.to_s
puts "Is strawberry tasty?"
puts b2.delicious?.to_s

# PART II: Object Oriented Programming

class Class
	def attr_accessor_with_history(attr_name)
		attr_name = attr_name.to_s
		attr_reader attr_name
		attr_reader attr_name + "_history"
		class_eval %Q"
			def #{attr_name}=value
				if !defined? @#{attr_name}_history
					@#{attr_name}_history = [@#{attr_name}]
				end
				@#{attr_name} = value
				@#{attr_name}_history << value
			end
		"
	end
end

class Foo
	attr_accessor_with_history :bar
end

# Test
f = Foo.new
f.bar = 1
f.bar = 2
puts f.bar_history.to_s

# PART III: More OOP
module Currency
    @@currencies = {'dollar' => 1.0, 'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
    attr_accessor :currency
    
    def method_missing(method_id, *args, &block)
        method_id = method_id.to_s.gsub( /s$/, '')
        if @@currencies.has_key?(method_id)
            @currency = method_id
            self
        else
            super
        end
    end
    

    def in(tar_currency)
		tar_currency = tar_currency.to_s.gsub( /s$/, '')
		result = (self *  @@currencies[@currency][tar_currency]).round(2)
		
		result.currency = tar_currency
		result
    end
end
class Numeric
	include Currency
end
# Test
#puts (1000.yen.in(:dollar))
#puts (492.rupees.in(:euro))
#puts (1000.dollar.in(:rupees))

# Updated Palindrome
class String
    def palindrome?()
		string = (self.gsub(/[^a-zA-Z]/, "")).downcase
		rstring = string.reverse
		
		return (string == rstring)
    end
end

puts ("RaCeCaR rAcEcAr".palindrome?)
puts ("Hingadingadurgen".palindrome?)

# Enumerated Palindrome
module Enumerable
    def palindrome?()
        string = self
        pal = []
        # iterates over every element of the object pal
        string.reverse_each {|i| pal << i}
        if(string == pal)
            true
        else
            false
        end
    end
end

puts ([1, 2, 3, 2, 1].palindrome?)

# PART IV: Blocks

class CartesianProduct
    include Enumerable
    def initialize(cart1, cart2)
        @cart1 = cart1
        @cart2 = cart2
    end
    def each
        @cart1.each do |i|
            @cart2.each do |j|
                yield ([i, j])
            end
        end
    end
end

# Test
test = CartesianProduct.new([:a, :b], [4, 5])
test.each { |elt| puts elt.inspect}
