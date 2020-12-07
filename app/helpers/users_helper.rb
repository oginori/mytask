module UsersHelper
  def admin_delete_judge
    if User.where(admin: true).count == 1 && current_user.id == @user.id
      flash[:notice] = '唯一の管理者の権限削除はできません。'
    else
      @user.update_columns(admin: false)
    end
  end
end
