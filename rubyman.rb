def draw_hangman(attempts_left)
  hangman_stages = [
    # 0 attempts left (dead)
    '
     +---+
     |   |
     O   |
    /|\  |
    / \  |
         |
    =========\n',
    # 1 attempt left
    '
     +---+
     |   |
     O   |
    /|\  |
    /    |
         |
    =========\n',
    # 2 attempts left
    '
     +---+
     |   |
     O   |
    /|\  |
         |
         |
    =========\n',
    # 3 attempts left
    '
     +---+
     |   |
     O   |
    /|   |
         |
         |
    =========\n',
    # 4 attempts left
    '
     +---+
     |   |
     O   |
     |   |
         |
         |
    =========\n',
    # 5 attempts left
    '
     +---+
     |   |
     O   |
         |
         |
         |
    =========\n',
    # 6 attempts left (start)
    '
     +---+
     |   |
         |
         |
         |
         |
    =========\n'
  ]
  
  puts hangman_stages[attempts_left]
end

def clear_screen
  system('cls') || system('clear')
end

# Get local dictionary for word list
DICTIONARY_FILE = "/usr/share/dict/words"

def play_rubyman
  # Setup

  # custom word list loading
  custom_dictionary = ARGV.length > 0 ? ARGV[0] : nil
  words = []

  if custom_dictionary && File.exist?(custom_dictionary_file)
    words = File.readlines(custom_dictionary).map(&:chomp).select { |word| word.length >= 4 && word.match?(/\A[a-zA-Z]+\z/) }.map(&:downcase)
    puts "Custom dictionary loaded."
  elsif File.exist?(DICTIONARY_FILE)
    words = File.readlines(DICTIONARY_FILE).map(&:chomp).select { |word| word.length >= 4 && word.match?(/\A[a-zA-Z]+\z/) }.map(&:downcase)
  end

  # fallback word list
  if words.empty?
	puts "Fallback wordlist being used"
	words = ["ruby", "oklahoma", "programming", "method", "class", "polytechnic", "array", "variable", "function", "object", "paradigm", "inheritance", "encapsulation", "abstraction", "algorithm", "university"]
  end

  # choose a random word
  secret_word = words.sample
  # array to hold guessed letters
  guessed_letters = []
  # number of attempts
  attempts_left = 6

  # Game loop
  while attempts_left > 0
    clear_screen
    puts "Welcome to RubyMan!"
    puts "Guess the word, one letter at a time.\n\n"
    
    draw_hangman(attempts_left)
    
    display_word = secret_word.chars.map { |letter| guessed_letters.include?(letter) ? letter : "_" }.join(" ")
    puts "\nWord: #{display_word}"
    puts "Attempts left: #{attempts_left}"
    puts "Guessed letters: #{guessed_letters.join(", ")}"
    print "Enter a letter: "
    guess = gets.chomp.downcase

    if guess.length != 1 || !('a'..'z').include?(guess)
      puts "Please enter a single letter."
      sleep(2)
      next
    end

    if guessed_letters.include?(guess)
      puts "You've already guessed that letter."
      sleep(2)
      next
    end

    guessed_letters << guess

    if secret_word.include?(guess)
      puts "Good guess!"
      sleep(2)
    else
      attempts_left -= 1
      puts "Wrong guess!"
      sleep(2)
    end

    if secret_word.chars.all? { |letter| guessed_letters.include?(letter) }
      clear_screen
      draw_hangman(attempts_left)
      puts "🎉 YOU WON! 🎉"
      puts "\nWord: #{secret_word}"
      puts "\nCongratulations! You've guessed the word: #{secret_word}"
      puts "Play again? (y/n)"
      play_again = gets.chomp.downcase
      if play_again == "y"
        play_rubyman
      end
      return
    end
  end

  clear_screen
  draw_hangman(0)
  puts "\n💀 GAME OVER! 💀"
  puts "The word was: #{secret_word}"
  puts "Play again? (y/n)"
  play_again = gets.chomp.downcase
  if play_again == "y"
    play_rubyman
  end
end

play_rubyman
