

class Game
  
end

class Computer
  def initialize(colors)
    puts "colors:"
    p colors
    @correct_seq = [colors.delete_at(rand(6)), colors.delete_at(rand(5)), colors.delete_at(rand(4)), colors.delete_at(rand(3))]
    @remaining_turns = 12
  end

  def play_round
    puts 'Select the 4 colors'
    colors = gets.chomp.split(" ")
    in_place = @correct_seq.filter.with_index {|color, index| color == colors[index]}.length
    out_place = @correct_seq.filter{|color| colors.include?(color)}.length - in_place
    puts "You have guessed #{in_place} number of colors"
    puts "You have guessed #{out_place} number of colors"
    p @correct_seq
    @remaining_turns -= 1
  end
end

class Player

end

colors = ["red", "green", "blue", "yellow", "orange", "black"]
computer = Computer.new(colors)
computer.play_round
