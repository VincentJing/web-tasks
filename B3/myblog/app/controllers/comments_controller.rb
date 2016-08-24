class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  # GET /comments
  # GET /comments.json
  def manage
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def index
    @comments = Comment.all
  end

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
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      render template: 'posts/show'
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update # 审核
    @post = Post.find(params[:post_id])
    @comment = set_comment
    @comment.status = true
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully passed.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
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

  def require_login
    unless session[:status]
      flash[:error] = '你当前未登录，请登录！'
      redirect_to login_admins_path
    end
  end
end
