class BookCommentsController < ApplicationController

	def create
		@book = Book.find(params[:book_id])
		@comment = current_user.book_comments.new(book_comment_params)
		@comment.book_id = @book.id
		@comment.save
		# 1つ前のページに戻る
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@book = Book.find(params[:book_id])
		# 下記は、(book_id: @book.id)が取得できないと削除できないという指定
		# 下記は、@book = Book.find(params[:book_id])の中からfind_by((FKの)book_id: @book.id)で2箇所で指定している。
		@book_comment = current_user.book_comments.find_by(book_id: @book.id)
		@book_comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:user_id, :book_id, :comment)
	end

end
