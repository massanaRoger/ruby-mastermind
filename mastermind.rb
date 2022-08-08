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

# Class to play the game as a player guessing
class Player < Game
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

# Class that executes the game making the computer guess the sequence
class Computer < Game
  def play_game
    puts 'Print the sequence to guess'
    @correct_seq = gets.chomp.split(' ')
    algotithm
  end

  private

  def colors_algorithm_inplace(colors, seq)
    seq.filter.with_index { |color, index| color == colors[index] }.length
  end

  def colors_algorithm_outplace(colors, seq)
    seq.filter { |color| colors.include?(color) }.length
  end

  def play_round(colors)
    in_place = colors_inplace(colors)
    out_place = colors_outplace(colors) - in_place
    [in_place, out_place]
  end

  def play_algorithm_round(colors, seq)
    in_place = colors_algorithm_inplace(colors, seq)
    out_place = colors_algorithm_outplace(colors, seq) - in_place
    [in_place, out_place]
  end

  def calc_combinations
    set = []
    i = 0
    j = 0
    k = 0
    l = 0
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
    while @remaining_turns.positive?
      hits = play_round(guess)
      p guess
      return true if hits[0] == 4

      set = set.filter { |seq| play_algorithm_round(guess, seq) == hits }
      guess = set[0]
      @remaining_turns -= 1
    end
  end
end

colors = %w[red green blue yellow orange black]
puts 'Press 1 to make computer guess, else you guess it yourself'
if gets.chomp.to_i == 1
  computer = Computer.new(colors)
  computer.play_game
else
  player = Player.new(colors)
  player.play_game
end
