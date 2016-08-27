class Welcome::PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
    render layout: 'welcome'
  end

  def search
    if params[:search].to_s == ''
      @posts = Post.paginate(page: params[:page], per_page: 10)
      render 'index'
    else
      @query = Post.search do
        fulltext params[:search]
      end
      @posts = @query.results
      if @posts.empty?
        flash[:notice] = '搜索结果为空'
        render 'index'
      else
        render 'index'
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @post = set_post
    @comments = Comment.where(post_id: params[:id].to_i, status: true)
    @comments = @comments.paginate(page: params[:page], per_page: 5)
    render layout: 'welcome'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
