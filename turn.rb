require './question'

module MathGame
  class Turn

    def initialize
      @question = Question.new
    end

    def ask_question
      puts @question.prompt
      print '> '
      answer = gets.gsub(/\D/, '').to_i
      @question.answer?(answer)
    end

  end
end
