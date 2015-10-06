class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new

  end

  def create

    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        flash[:success] = "Save Success!"
        format.html { redirect_to articles_path }
      else
        flash[:error] = "Save Failed!"
        format.html { redirect_to articles_path }
      end
    end

  end

  private

  def article_params
    params.require(:article).permit!
  end
end
