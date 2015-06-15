class ArticlesController < ApplicationController 
  def index
    #Article.all.delete
    #Tag.all.delete
    #Comment.all.delete
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end

  def show_tagged
    @list_articles = []
    @select_tag = Tag.where( name: params[:name] )[0]
    @select_tag.article_ids.each do |article_id|
      @list_articles.push( Article.where( _id: article_id )[0] )
 #  render plain: Tag.where( name: params[:name] )[0].article_ids
    end
  end
 
  def new
    @new_article = Article.new
  end
 
  def edit
    @new_article = Article.find(params[:id])
    @p=0
    @temp= []
    while @p<@new_article.count_tags.to_i
      @temp[@p]= @new_article.tags[@p].name
      @p=@p+1
     end
     @temp2=@temp.join(',')
  end
 
  def create
    @temp2 = ""
    @new_article = Article.new(article_params)
    @tag = Tag.new(tag_params)    
    @count_tag = params.require(:article).permit(:count_tags)
    @i = 0
    @k = 0
    @tag_name = tag_params[:name].split(/[,]+/)
    @new_tags = []
    while @i<@count_tag[:count_tags].to_i
      @exists_tag = Tag.where( name: @tag_name[@i] )
      if @exists_tag.count>0
        @exists_tag = @exists_tag[0]
      else
        @exists_tag = Tag.new(name: @tag_name[@i])
#        @exists_tag.push( article_ids: @new_article._id )
        if @exists_tag.save
          @new_tags[@k] = @exists_tag
          @k = @k + 1 
        end
       end
      @new_article.push( tag_ids: @exists_tag._id)
      @exists_tag.push( article_ids: @new_article._id )
      @exists_tag.update
      @i = @i + 1
    end
    if @new_article.save
        redirect_to @new_article
    else
      @i = 0
      while @i<@k
        @new_tags[@i].delete
        @i = @i + 1
      end   
      render 'new'
     end
  end
 
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
 
  private
    def article_params
      params.require(:article).permit( :title, :text, :count_tags)
    end
  private
    def tag_params
      params.require(:tag).permit(:name)
    end

end
