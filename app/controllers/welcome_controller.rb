class WelcomeController < ApplicationController

  def index
    @question = Question.new
  end


  private

  def question_params
    params.require(:question).permit('question', 'email')
  end

end
