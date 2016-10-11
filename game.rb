require './player'
require './turn'

module MathGame
  class Game

    def initialize()
      @players = []
      @current_player_index = 0
      @game_over = false
      @turn_num = 1
      @max_lives = 0
    end

    def start

      # Get the number of players
      puts 'How many players?'
      num_players = get_number_input

      # If the input was bad
      while num_players <= 1 do
        puts 'There must be more than 1 player'
        num_players = get_number_input
      end

      # Get the number of lives
      puts 'Starting life?'
      @max_lives = get_number_input

      # If the input was bad
      while @max_lives == 0 do
        puts 'Starting life must be more than 0'
        @max_lives = get_number_input
      end

      # Get the players to input their names
      (1..num_players).each do |player_num|
        puts "Player #{player_num}, what is your name?"
        name = gets.chomp
        @players << Player.new(name, player_num, @max_lives)
      end

      # Main loop
      update
    end

    def update
      while !@game_over do
        puts "--- Turn #{@turn_num} ---"
        @turn_num += 1

        # Show the players' health
        print '*'
        @players.each do |player|
          print " #{player.name}: #{player.lives}/#{@max_lives} *"
        end
        # New line
        puts

        # Ask a new question to the current player
        print "#{@players[@current_player_index].name}: "
        turn = Turn.new
        success = turn.ask_question
        answer_response(success)
      end

      # Next player's turn
      @current_player_index = (@current_player_index + 1) % @players.length
    end

    def answer_response(success)
      # Evaluate the answer
      if success
        puts 'Yes. ✓'
      else
        puts 'Nope. ✗'
        @players[@current_player_index].lose_life

        # If the player has no lives left
        if @players[@current_player_index].lives <= 0
          puts "#{@players[@current_player_index].name} has died of incorrect addition."
          @players.delete_at(@current_player_index)
          @current_player_index -= 1

          # If there is only 1 player left, that player wins!
          if @players.length <= 1
            @game_over = true
            puts "--- GAME OVER ---\n#{@players[0].name} wins!"
            puts "Lives remaining: #{@players[0].lives}/#{@max_lives}"
          end
        end
      end

    end

    def get_number_input
      gets.gsub(/\D/, '').to_i
    end

  end
  # Run the game
  Game.new.start
end
