class ChoicesController < ApplicationController
  before_action :admin,     only: [:index, :create, :destroy]
  def index
    @choice = Choice.new
    @choices = Choice.order("created_at desc")
  end
  
  def create
    @choice = Choice.new(choice_params)
    if @choice.save
      redirect_to ({action: :index}), flash: { success: "選択肢が保存されました"}
    else
      redirect_to ({action: :index}), flash: { danger: "選択肢が保存されませんでした"}
    end
  end
  
  def destroy
    Choice.find(params[:id]).destroy
    redirect_to ({action: :index, status: :see_other}), flash: { success: "削除しました"}
  end

  private
    def admin
     redirect_to(root_url, status: :see_other) unless logged_in?
    end
    
    def choice_params
      params.require(:choice).permit(:text)
    end
end