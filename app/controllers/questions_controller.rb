class QuestionsController < ApplicationController

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)
    if @question.save
      flash.now[:success] = 'Got it, thanks'
    else
      flash.now[:error] = @question.errors.full_messages[0]
    end

    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript' }
    end
  end


  private

  def question_params
    params.require(:question).permit('question', 'email')
  end

end
