require_relative 'player'
require_relative 'word'
require 'json'

class Game 

  MAX_ATTEMTPS = 6

  attr_reader :game_word, :player, :attempt, :guess_array

    def initialize(attempt = 0, word = nil, crypted_word = nil, guess_array = [])
      @player = Player.new('player')
      @attempt = attempt
      @guess_array = guess_array

      if word.nil?
        @game_word = Word.new((Word.list_treatment("word_list.txt")))
      else
        @game_word = Word.new(nil, word, crypted_word)
      end
    end

    def game_loop
      puts @game_word.word
      puts "The Game choose the word: "
      while self.attempt < MAX_ATTEMTPS
        
        puts "\t#{self.game_word.display}"
        puts "\nGuesseed letters:  #{@guess_array.join(', ').upcase}" unless self.guess_array.empty? 
        puts
        guess = self.player.make_guess
          if guess == "0"
            self.save_game
            puts "The game has been saved successfully"
            return
          end
        
        output = self.game_word.compare_guess(guess)

        puts 
        win_condition = self.game_word.win?

        if win_condition == true
          puts "Congrats! You won the game!"
           self.game_word.display
           delete_json
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
      delete_json
    end

    def to_json
      JSON.pretty_generate({
        :attempt => @attempt,
        :word => @game_word.word,
        :crypted_word => @game_word.crypted_word,
        :guess_array => @guess_array
      })
    end

    def self.from_json(string)
      data = JSON.parse(string)

      self.new(data['attempt'], data['word'], data['crypted_word'], data['guess_array'])
    end

    def save_game
      saves_path = File.expand_path('saves', __dir__) 
      file_path = File.join(saves_path, "save.json")
      File.write(file_path, self.to_json)
    end

    def delete_json
      saves_path = File.expand_path('saves', __dir__) 
      file_path = File.join(saves_path, "save.json")
      File.delete(file_path) if File.exist?(file_path)
    end
end

