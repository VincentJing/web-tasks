class Welcome::CategoriesController < ApplicationController
  def posts
    category = Category.find(params[:id])
    @posts = category.posts.paginate(page: params[:page], per_page: 10)
    render 'welcome/posts/index', layout: 'welcome'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:title)
  end
end
