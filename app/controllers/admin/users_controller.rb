class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[show destroy toggle_status]

  def index
    @users = User.order(id: :desc).page params[:page]
  end

  def show; end

  def update
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'تم حذف المستخدم بنجاح'
  end

  def toggle_status
    if @user.access_locked?
      @user.unlock_access!
    else
      @user.lock_access!
    end

    redirect_to admin_users_path, notice: 'تم تحديث حالة المستخدم بنجاح'
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def update_params
    # params.required(:user).permit(:locked)
  end
end
