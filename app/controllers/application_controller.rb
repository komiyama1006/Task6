class ApplicationController < ActionController::Base 
	# 下記をアプリケーションに書くと、ログイン状態でないと必ずログイン画面に遷移してしまう。
  # before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	protect_from_forgery with: :exception

  protected
  def after_sign_in_path_for(resource)
    # ログイン後に遷移する画面先のリンク
    # 下記を書くことで、ログイン状態で「sigh_in」「sign_up」ボタンを押したら、ユーザーの詳細画面に遷移する
    user_path(current_user)
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    # ログアウト後に遷移する画面先のリンク
    root_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
  end
end
