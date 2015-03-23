class UsersController < ApplicationController
  before_action :authenticate_user!
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @disableds = @users.select { |user| user.status == 'DISABLED' }
    @okays = @users.select { |user| user.status == 'OK' }
    @terminateds = @users.select { |user| user.status == 'TERMINATED' }
    @offices = Office.all
  end

  # GET /users/
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  def disable
    @user = User.find(params[:id])
    @status = @user.status
    @user.update_attribute(:status, "DISABLED")
    redirect_to "/manage"
  end 

  def terminate
    @user = User.find(params[:id])
    @user.update_attribute(:status, "TERMINATED")
    redirect_to "/manage"
  end 

  def restore
    @user = User.find(params[:id])
    @status = @user.status
    @user.update_attribute(:status, "OK")
    redirect_to "/manage"
  end 

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
