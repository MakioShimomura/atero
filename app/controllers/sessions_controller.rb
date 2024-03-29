class SessionsController < ApplicationController
  def new
  end
  
  def create
    admin = Admin.find_by(email: params[:session][:email].downcase)
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      flash.now[:success] = '管理者としてログインしました'
      redirect_to root_path
    else
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが無効です'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
