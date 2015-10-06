class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
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

  def edit
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html { render "edit" }
    end
  end

  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes!(article_params)
        flash[:success] = "Success!"
      else
        flash[:error] = "Errors!"
      end
      format.html { redirect_to articles_path }
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_path }
    end
  end

  private

  def article_params
    params.require(:article).permit!
  end
end
