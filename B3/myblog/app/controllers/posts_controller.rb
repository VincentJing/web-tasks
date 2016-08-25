class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
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
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    category = Category.find_by(title: params[:category].to_s)
    @post = category.posts.create(post_params)
    respond_to do |format|
      if @post.valid?
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if Category.find_by(title: params[:category].to_s).id == @post.categories[0].id # 重新编辑时分类是否改变
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      @post.destroy
      category = Category.find_by(title: params[:category].to_s)
      @post = category.posts.create(post_params)
      respond_to do |format|
        if @post.valid?
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
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

  def require_login
    unless session[:status]
      flash[:error] = '你当前未登录，请登录！'
      redirect_to login_admins_path
    end
  end
end
