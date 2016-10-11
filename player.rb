module MathGame
  class Player
    
    attr_accessor :name, :player_num
    attr_reader :lives, :dead

    def initialize(name, player_num, lives)
      @name = name
      @player_num = player_num
      @lives = lives
      @dead = false
    end

    def lose_life
      @lives -= 1
      dead = true if @lives <= 0
    end

  end
end
