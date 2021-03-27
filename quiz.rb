# Prompts the user for two integers.
# - The first one should be between 1 and 4, with
#   * 1 meaning initially looking North,
#   * 2 meaning initially looking East,
#   * 3 meaning initially looking South,
#   * 4 meaning initially looking West.
# - The second one should be positive. When written in base 3, its consecutive
#   digits read from left to right represent the directions to take, with
#   * 0 meaning going in the direction one is initially looking at,
#   * 1 meaning 45 degrees left of the direction one is initially looking at,
#   * 2 meaning 45 degrees right of the direction one is initially looking at.
#
# Prints out:
# - the direction one is originally looking at, as an arrow,
# - the representation of the second digit in base 3,
# - the corresponding sequence of directions to take, as arrows,
# - in case one is originally looking North or South, the path,
#   so the sequence of arrows again, but nicely displayed.
# - you may use the unicode array for output: ['↑', '↗', '→', '↘', '↓', '↙', '←', '↖']

begin
	print('Enter an integer between 1 and 4 and a positive integer: ')
	initial_direction, directions = gets.split()
	if initial_direction.size != 1 || directions.size > 1 && directions[0] == '0'
			raise ArgumentError
	end

	initial_direction = initial_direction.to_i
	directions = directions.to_i
	if ![1, 2, 3, 4].include?(initial_direction) || directions < 0
		raise ArgumentError
	elsif initial_direction == 1
		initial_arrow, arrow_1, arrow_2 = "↑", "↖", "↗"
	elsif initial_direction == 2
		initial_arrow, arrow_1, arrow_2 = "→", "↗", "↘"
	elsif initial_direction == 3
		initial_arrow, arrow_1, arrow_2 = "↓", "↘", "↙"
	elsif initial_direction == 4
		initial_arrow, arrow_1, arrow_2 = "←", "↙", "↖"
	end
		
	puts("Ok, you want to first look this way: #{initial_arrow}")
	puts("In base 3, the second input reads as: #{directions.to_s(base=3)}")
	directions_numbers = directions.to_s(base=3).split(//)
	
	directions_arrow_arr = []
	directions_numbers.each do |number|
		arrow = initial_arrow if number == "0"
		arrow = arrow_1 if number == "1"
		arrow = arrow_2 if number == "2"
		directions_arrow_arr << arrow
	end
	
	puts("So that's how you want to go: #{directions_arrow_arr.join}")
	# i = directions_numbers.count(directions_numbers.max_by { |i| directions_numbers.count(i) })
	
	if [2, 4].include? initial_direction
		puts("I don't want to have the sun in my eyes, but by all means have a go at it!")
	else
		i = 0 # 初始箭頭的x軸位置
		position = []
		directions_arrow_arr.each do |element|
			if ["↗","↘"].include? element 
				position << i
				i += 1
			elsif element == initial_arrow
				position <<  i
			elsif !["↗","↘", initial_arrow].include? element 
				if i >= 1
					i -= 1
					position << i 
				else
					i = 0
					position.map!{ |p| p + 1 }
					position << i
				end
			end
		end
		
		if ["↖","↗"].include? directions_arrow_arr[0]
			position.zip(directions_arrow_arr).reverse.each do | i, footstep |
				puts $/ * 0 + " " * i + footstep
			end
		else
			position.zip(directions_arrow_arr).each do | i, footstep |
				puts $/ * 0 + " " * i + footstep
			end
		end
	end
    
rescue ArgumentError => e
	print("Incorrect input, giving up.\n")
	exit
end
