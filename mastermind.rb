# frozen_string_literal: true

class Game
end

# Class to play the game with the colors selected by the computer
class Computer
  def initialize(colors)
    puts 'colors:'
    p colors
    @correct_seq = [colors.delete_at(rand(6)), colors.delete_at(rand(5)), colors.delete_at(rand(4)),
                    colors.delete_at(rand(3))]
    @remaining_turns = 12
  end

  def play_game
    while @remaining_turns.positive?
      break if play_round

      puts "Remaining turns: #{@remaining_turns}"
    end
    if @remaining_turns.zero?
      puts 'You lost!'
    else
      puts "Congradulations, you won with #{@remaining_turns} remaining turns!"
    end
  end

  private

  def decrement_turn
    @remaining_turns -= 1
  end

  def colors_inplace(colors)
    @correct_seq.filter.with_index { |color, index| color == colors[index] }.length
  end

  def colors_outplace(colors)
    @correct_seq.filter { |color| colors.include?(color) }.length
  end

  def play_round
    puts 'Select the 4 colors'
    colors = gets.chomp.split(' ')
    in_place = colors_inplace(colors)
    out_place = colors_outplace(colors) - in_place
    puts "You have guessed #{in_place} colors in place"
    puts "You have guessed #{out_place} colors out of place"
    p @correct_seq
    decrement_turn
    in_place == 4
  end
end

class Player
end

colors = %w[red green blue yellow orange black]
computer = Computer.new(colors)
computer.play_game
