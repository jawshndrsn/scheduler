class UsersController < ApplicationController

  before_filter :authenticate, :except => [:new, :create]
  load_and_authorize_resource
  #before_filter :authenticate_admin
  # GET /users
  # GET /users.json
  def index
    @users = User.page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  def followings
    follows = current_user.follows_by_type('Candidate')
    @candidates = Candidate.where("id in (#{follows.map(&:followable_id).join(',')})").page(params[:page])
    @tags = Candidate.tag_counts_on(:tags)
  end

  def password_change
    @user = current_user
    if @user.update_attributes(params[:user]) && request.put? && (not params[:user][:password].blank?)
      redirect_to :root, :notice => 'Password changed successfully.'
    elsif request.put? && (params[:user][:password].blank?)
      redirect_to password_change_path, :notice => 'Password should not be blank.'
    end
  end
end
