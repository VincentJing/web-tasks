class Welcome::CommentsController < ApplicationController
  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.status = false
    if @comment.save
      redirect_to :back, notice: '评论已经成功创建，正在审核中！'
    else
      @comments = @post.comments.where(status: false).paginate(page: params[:page], per_page: 5)
      render template: 'welcome/posts/show'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:post_id, :content, :email)
  end
end
