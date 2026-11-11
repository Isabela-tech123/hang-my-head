class Player 
  
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def make_guess

    loop do
       puts "Choose one letter and make your guess!"
      guess = gets.chomp.downcase

      if guess.length != 1 
        puts "You can only choose ONE letter per time"
      else
        break guess
      end
    end
  end


end