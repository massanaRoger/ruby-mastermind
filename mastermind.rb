# frozen_string_literal: true

# Class to play the game with the colors selected by the computer
class Game
  def initialize(colors)
    @colors = Marshal.load(Marshal.dump(colors))
    puts 'colors:'
    p colors
    @correct_seq = [colors[rand(6)], colors[rand(6)], colors[rand(6)], colors[rand(6)]]
    @remaining_turns = 12
    p @correct_seq
  end


  protected 

  def decrement_turn
    @remaining_turns -= 1
  end

  def colors_inplace(colors)
    @correct_seq.filter.with_index { |color, index| color == colors[index] }.length
  end

  def colors_outplace(colors)
    @correct_seq.filter { |color| colors.include?(color) }.length
  end

end

class Player < Game

  def initialize(colors)
    super(colors)
  end

  def play_game
    while @remaining_turns.positive?
      break if play_round_player
      puts "Remaining turns: #{@remaining_turns}"
    end
    if @remaining_turns.zero?
      puts 'You lost!'
    else
      puts "Congradulations, you won with #{@remaining_turns} remaining turns!"
    end
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

class Computer < Game

  def initialize(colors)
    super(colors)
  end

  def play_game
#    while @remaining_turns.positive?
 #     break if play_round
  #    puts "Remaining turns: #{@remaining_turns}"
  #  end
  #  if @remaining_turns.zero?
  #    puts 'You lost!'
  #  else
  #    puts "Congradulations, you won with #{@remaining_turns} remaining turns!"
  #  end
    algotithm
  end
  
  private

  def play_round(colors)
    in_place = colors_inplace(colors)
    out_place = colors_outplace(colors) - in_place
    [in_place, out_place]
  end

  def calc_combinations
    set = []
    i = 0; j = 0; k = 0; l = 0
    while i < 6
      while j < 6
        while k < 6
          while l < 6
            set.push([@colors[i], @colors[j], @colors[k], @colors[l]])
            l += 1
          end
          l = 0
          k += 1
        end
        k = 0
        j += 1
      end
      j = 0
      i += 1
    end
    set
  end

  def algotithm
    set = calc_combinations
    guess = [@colors[0], @colors[0], @colors[1], @colors[1]]
    hits = play_round(guess)
    p hits
  end

end

colors = %w[red green blue yellow orange black]
computer = Computer.new(colors)
computer.play_game
