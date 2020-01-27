class HomeController < ApplicationController
  def top
  	# 下記はログイン状態でサインインを押した際にユーザー詳細画面に遷移する記述だった。
  	# if user_signed_in?
  	# 	redirect_to user_path(current_user)
  	# end
  end

  def about
  end
end
