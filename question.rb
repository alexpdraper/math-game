module MathGame
  class Question

    attr_reader :prompt

    def initialize
      num_1 = rand(20) + 1
      num_2 = rand(20) + 1
      @prompt = "What is #{num_1} + #{num_2}?"
      @answer = num_1 + num_2
    end

    def answer?(guess)
      @answer == guess
    end

  end
end
