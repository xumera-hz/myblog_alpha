class TagsController < ApplicationController
  def show
    if params[:tag].presence.nil?   
      @tags = Tag.all
    else
      if params[:tag][:name].blank?
        @tags = Tag.all
      else      
        @tags = Tag.where(:name => /#{tag_params[:name]}/)
      end
    end   
  end
  def create
    @article = Article.find(params[:article_id])
    @tag = @article.tags.create(tag_params)
    redirect_to article_path(@article)
  end
  def destroy
    @article = Article.find(params[:article_id])
    @tag = @article.tags.find(params[:id])
    @tag.destroy
    redirect_to article_path(@article)
  end
  private
  def tag_params
    params.require(:tag).permit( :name)
  end
end
