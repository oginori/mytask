module UsersHelper
  def admin_delete_judge
    if current_user.id = @user.id
      flash[:notice] = '管理者の権限削除はできません。'
    else
      @user.update_columns(admin: false)
    end
  end
end
