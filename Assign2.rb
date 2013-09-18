#Name: Chris Fichman
#Program: Assign2.rb
#Email: chris.fichman@gmail.com
#Last Edit: 9/17/2013

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

b1 = JellyBean.new("Bean", 4, "black licorice")
b2 = JellyBean.new("Bean", 4, "Strawberry")

puts "Is b1 healthy?"
puts b1.healthy?.to_s
puts "Is b1 tasty?"
puts b1.delicious?.to_s
puts "Is b2 healthy?"
puts b2.healthy?.to_s
puts "Is b2 tasty?"
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

f = Foo.new
f.bar = 1
f.bar = 2
puts f.bar_history.to_s
