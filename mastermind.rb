

class Game
  
end

class Computer
  def initialize(colors)
    @correct_seq = [colors.delete_at(rand(6)), colors.delete_at(rand(5)), colors.delete_at(rand(4)), colors.delete_at(rand(3))]
    p @correct_seq
  end
end

class Player

end

colors = ["red", "green", "blue", "yellow", "orange", "black"]
computer = Computer.new(colors)
