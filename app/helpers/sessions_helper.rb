module SessionsHelper
  #渡されたアドミンでログインする
  def log_in(admin)
    session[:admin_id] = admin.id
  end
  
  # 現在ログイン中のアドミンを返す（いる場合）
  def current_admin
    if session[:admin_id]
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    end
  end
  
  # アドミンがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_admin.nil?
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    reset_session
    @current_admin = nil   # 安全のため
  end
end
