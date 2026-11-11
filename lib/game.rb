require_relative 'player'
require_relative 'word'

class Game 

  MAX_ATTEMTPS = 6

  attr_reader :game_word, :player, :attempt

    def initialize
      @game_word = Word.new((Word.list_treatment("word_list.txt")))
      @player = Player.new('player1')
      @attempt = 0
    end

    def game_loop
      
      puts @game_word.word
      puts "The Computer choose the word: "
      
      while self.attempt < MAX_ATTEMTPS
        self.game_word.display

        guess = self.player.make_guess
        output = self.game_word.compare_guess(guess)

        win_condition = self.game_word.win?

        if win_condition == true
          puts "Congrats! You won the game!"
           self.game_word.display
        return
        end
        
        unless output
          @attempt += 1
          puts "Wrong attempt, you still have #{MAX_ATTEMTPS - @attempt} remaining attempts"
        end
      end
      
      puts "Game Over..."
      puts "The correct word was ..."
    end
end