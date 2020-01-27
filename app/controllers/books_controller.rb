class BooksController < ApplicationController 
  before_action :authenticate_user!
  def show
  	@book = Book.find(params[:id])
    @books = Book.new
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    # 下記 @bookレコードの=(.) user_idカラムに=(=) current_userrレコードの=(.) idを代入する
    @book.user_id = current_user.id
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
      # 下記は、新規投稿のセーブに失敗した時
  		@books = Book.all
      # セーブに失敗したので、idの取得ができない。そのため、idを必要としないページにレンダーを指定する必要がある。
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    if current_user == @book.user
    else
      redirect_to books_path
    end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
