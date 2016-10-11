require './player'
require './turn'

module MathGame
  class Game

    def initialize()
      @players = []
      @current_player_index = 0
    end

    def start

      # Default game_over to false
      game_over = false

      # Default turn_num to 1
      turn_num = 1

      # Get the number of players
      puts 'How many players?'
      num_players = gets.gsub(/\D/, '').to_i

      # If the input was bad
      while num_players <= 1 do
        puts 'There must be more than 1 player'
        num_players = gets.gsub(/\D/, '').to_i
      end

      # Get the number of lives
      puts 'Starting life?'
      max_lives = gets.gsub(/\D/, '').to_i

      # If the input was bad
      while max_lives == 0 do
        puts 'Starting life must be more than 0'
        max_lives = gets.gsub(/\D/, '').to_i
      end

      # Get the players to input their names
      (1..num_players).each do |player_num|
        puts "Player #{player_num}, what is your name?"
        name = gets.chomp
        @players << Player.new(name, player_num, max_lives)
      end

      # Main loop
      while !game_over do
        puts "--- Turn #{turn_num} ---"
        turn_num += 1

        # Show the players' health
        print '*'
        @players.each do |player|
          print " #{player.name}: #{player.lives}/#{max_lives} *"
        end
        # New line
        puts

        # Ask a new question to the current player
        print "#{@players[@current_player_index].name}: "
        turn = Turn.new
        success = turn.ask_question

        # Evaluate the answer
        if success
          puts 'Yes. ✓'
        else
          puts 'Nope. ✗'
          @players[@current_player_index].lose_life
          if @players[@current_player_index].lives <= 0
            puts "#{@players[@current_player_index].name} has died of incorrect addition."
            @players.delete_at(@current_player_index)
            @current_player_index -= 1
            if @players.length <= 1
              game_over = true
              puts "--- GAME OVER ---\n#{@players[0].name} wins!"
              puts "Lives remaining: #{@players[0].lives}/#{max_lives}"
            end
          end
        end

        # Next player's turn
        @current_player_index = (@current_player_index + 1) % @players.length

      end
    end

  end
  # Run the game
  Game.new.start
end
