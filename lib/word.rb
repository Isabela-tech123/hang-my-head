class Word 

    attr_reader :word, :crypted_word

    def self.list_treatment(file_name)

      file_path = File.expand_path(file_name, __dir__)
      if File.exist?(file_path)
            File.readlines(file_path).map(&:chomp).select { |word| word.length.between?(4, 12)}
      else 
        puts "ERROR, File can not be found"
      end
    end

    def initialize(word_list = nil, saved_word = nil, saved_crypted = nil)
      if saved_word.nil?
        @word = word_list.sample.upcase
      @crypted_word = Array.new(@word.length, "-")
      else 
        @word = saved_word
        @crypted_word = saved_crypted
      end
    end

    def compare_guess(player_guess)
      letter = player_guess.upcase
      right_attempt = false
     self.word.each_char.with_index do |char, index|
          if char == letter
            self.crypted_word[index] = letter
            right_attempt = true
            puts "This word cointains #{letter}! at  position #{index}"
          end
     end 
     right_attempt
    end

    def display
      puts self.crypted_word.join(" ")
    end

    def win?
      !self.crypted_word.include?("-")
    end
    
end