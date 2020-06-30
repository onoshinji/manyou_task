class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user?

  def index
    @users = User.all
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def admin_user?
    redirect_to root_path unless current_user.admin?
  end
end
