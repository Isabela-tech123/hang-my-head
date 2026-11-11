require_relative 'player'
require_relative 'word'

class Game 

  MAX_ATTEMTPS = 6

  attr_reader :game_word, :player, :attempt, :guess_array

    def initialize
      @game_word = Word.new((Word.list_treatment("word_list.txt")))
      @player = Player.new('player1')
      @attempt = 0
      @guess_array = []
    end

    def game_loop
      puts @game_word.word
      puts "The Game choose the word: "
      while self.attempt < MAX_ATTEMTPS
        
        puts "\t#{self.game_word.display}"
        puts "\nGuesseed letters:  #{@guess_array.join(', ').upcase}" unless self.guess_array.empty? 
        puts
        guess = self.player.make_guess
        
        output = self.game_word.compare_guess(guess)

        puts 
        win_condition = self.game_word.win?

        if win_condition == true
          puts "Congrats! You won the game!"
           self.game_word.display
        return
        end

        if guess_array.include?(guess)
          puts "You already typed the letter #{guess}"
        end
        guess_array.push(guess)
        unless output
          @attempt += 1
          if @attempt == 6
            puts "Wrong attempt, you have...zero atempts"
          else 
          puts "Wrong attempt, you still have #{MAX_ATTEMTPS - @attempt} remaining attempts"
          end 
        end
      end
      puts
      puts "Game Over..."
      puts "The correct word was #{@game_word.word}"
    end
end