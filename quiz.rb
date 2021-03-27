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
      initial_arrow = "↑"
      arrow_1 = "↖"
      arrow_2 = "↗"
  elsif initial_direction == 2
      initial_arrow = "→"
      arrow_1 = "↗"
      arrow_2 = "↘"
  elsif initial_direction == 3
      initial_arrow = "↓"
      arrow_1 = "↘"
      arrow_2 = "↙"
  elsif initial_direction == 4
      initial_arrow = "←"
      arrow_1 = "↙"
      arrow_2 = "↖"
  end
  
  puts("")
  sleep 1
  puts("Ok, you want to first look this way: #{initial_arrow}")
  puts("")
  sleep 1
  puts("In base 3, the second input reads as: #{directions.to_s(base=3)}")
  directions_numbers = directions.to_s(base=3).split(//)

  directions_arrow_arr = []
  directions_numbers.each do |number|
    if number == "0"
      arrow = initial_arrow
    elsif number == "1"
      arrow = arrow_1
    elsif number == "2"
      arrow = arrow_2
    end
    directions_arrow_arr << arrow
  end
  
  puts("So that's how you want to go: #{directions_arrow_arr.join}")
  puts("") 
  sleep 1
  if initial_direction == 2 || initial_direction == 4
    puts("I don't want to have the sun in my eyes, but by all means have a go at it!")
  else
    puts("Let's go then!")
    routes = []
    i = 0 # number of " "
    directions_arrow_arr.each.with_index do |element, index|
    if directions_arrow_arr[0] == "↘" || directions_arrow_arr[0] == "↗"
      if i == 0 && index == 0
        routes << directions_arrow_arr[index]
        i += 1
      elsif directions_arrow_arr[index] == directions_arrow_arr[0] && index != 0 && i >= 0
        routes << " " * i + directions_arrow_arr[index]
        i += 1
      elsif directions_arrow_arr[index] == initial_arrow && i >= 0
          routes << " " * i + initial_arrow
      elsif directions_arrow_arr[index] != initial_arrow && directions_arrow_arr[index] != directions_arrow_arr[0] 
        if i > 0
          i -= 1
          routes << " " * i + directions_arrow_arr[index]
        elsif i <= 0
          routes.map! { |route| " " + route }
          routes << directions_arrow_arr[index]
          i = 0
        end
      end
  
      elsif directions_arrow_arr[0] == "↙" || directions_arrow_arr[0] == "↖"
        if i == 0 && index == 0
          routes << directions_arrow_arr[index]
          i = 0
        elsif directions_arrow_arr[index] == initial_arrow && i >= 0
            routes << " " * i + initial_arrow
        elsif directions_arrow_arr[index] == directions_arrow_arr[0] 
          if i > 0
            i -= 1
            routes << " " * i + directions_arrow_arr[index]
          elsif i <= 0
            routes.map!{|route| " " + route}
            routes << directions_arrow_arr[index]
            i = 0
          end
        elsif directions_arrow_arr[index] != initial_arrow && directions_arrow_arr[index] != directions_arrow_arr[0]
          routes << " " * i + directions_arrow_arr[index] 
          i += 1
        end
      elsif directions_arrow_arr[0] == initial_arrow
        routes <<  initial_arrow
      end
    end
  
    if directions_arrow_arr[0] == "↗" || directions_arrow_arr[0] == "↖"
      routes.reverse.each do |route|
        puts route
      end
    else
      routes.each do |route|
        puts route
      end
    end
  end    

rescue ArgumentError => e
  print("Incorrect input, giving up.\n")
  exit
end
