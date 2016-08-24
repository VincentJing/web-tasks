class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def login
    @admin = Admin.new
  end

  def check_login
    @admin = Admin.new(admin_params)
    if Admin.check_login(@admin)
      session[:status] = true
      redirect_to posts_path
    else
      redirect_to login_admins_path
    end
  end

  def exit
    session[:status] = false
    redirect_to login_admins_path
  end

  def signup
    @admin = Admin.new
  end

  def index
    @admins = Admin.all
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to login_admins_path, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.require(:admin).permit(:name, :password)
  end
end
