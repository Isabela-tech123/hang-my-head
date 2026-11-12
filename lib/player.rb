class Player 
  
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def make_guess

    loop do
       puts "Choose one letter and make your guess!"
       puts "Hint! You can press '0' to exit, and the game will be saved!"
      guess = gets.chomp.downcase

      break guess if guess == "0"
      
      if guess.length != 1 
        puts "You can only choose ONE letter per time"
      elsif !guess.match?(/[a-z]/)
        puts "You can only type letters!"
      else
        break guess
      end
    end
  end


end