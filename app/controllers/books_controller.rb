class BooksController < ApplicationController
	before_action :authenticate_user!
    def create#投稿系の指示！！
  	 @book = Book.new(book_params)#新しい本の投稿の指示+新規投稿呼び出しの指示（idはbook paramsから所得）
     @book.user_id = current_user.id#current_user_idはログイン済みのこと。←空のユーザーの本の投稿情報にログイン済みのユーザーが投稿情報を入れる。
    if @book.save#もし本の投稿に成功したら？
     flash[:notice] = "You have creatad book successfully."#成功した場合成功のメッセージ
     redirect_to book_path(@book.id)#投稿が成功した場合の遷移ページの指定。←この場合はbooksのshowページに遷移している。idの確認の仕方はrails rotuesで確認。
    else#投稿が成功しなかったら
      @books = Book.all#投稿した全てのbooksの情報をブックスモデルから呼び出す。
      @user = current_user#ログイン済みのユーザーの情報を@userインスタンス変数に代入し表示

        flash[:error] = "1 error prohibited this obj from being saved:Body can't be blank"#もし失敗した場合のエラーメッセージ
        render :index#失敗した場合の遷移先。renderとredirect_toの違いは・renderは表示させるviewファイルを指定（showやindexなど。）・redirect_toはURL(HTTPリクエストメソッド＝パスね）を指定
    end

end
   def index#一覧ページ！！
    @user = current_user#ログイン済みのユーザーの一覧ページを表示。何度も言うがcurrent_userはログイン済みのユーザーである。
  	@books = Book.all#一覧ページ（booksのindexページ！）に本の投稿データの全てを表示＊＠マークのついているインスタンス変数はviewページに表示。
  	@book = Book.new#本の新規投稿の情報を一覧ページ（booksのindexページ！）に表示
end

  def show#投稿した本の詳細ページ。
  	 @book = Book.find(params[:id])#投稿した本を区別する為のカラム（id）の振り分け。
     @user = @book.user#←読み下し→このユーザーのこの本の（ユーザーの本のインスタンス変数）情報をユーザーのインスタンス変数に代入し表示。（@book.userの読み下しはユーザーが代入したい本の情報）
     @new_book = Book.new#新しい本のインスタンス変数の中に投稿したい本のローカル変数を代入し表示。
     @book_comment = BookComment.new
     @book_comments = @book.book_comments
  end


  def edit#投稿した情報の編集ページ（book!!）
  	@book = Book.find(params[:id])#投稿した本を区別する為のカラム（id）の振り分け。
    if @book.user_id != current_user.id#もしログイン済みのユーザーが情報の編集に成功したら
     redirect_to books_path#booksのeditページに遷移する
   end
   end

  def update#情報の更新
  	@book = Book.find(params[:id])#投稿した本を区別する為のカラム（id）の振り分け。
    @book.user_id = current_user.id#もしログイン済みのユーザーが情報の更新に成功したら
if  @book.update(book_params)#もし本の再投稿に成功したら？
    flash[:notice] = "You have creatad book successfully."
  	redirect_to book_path(@book.id)#成功した場合booksのindexに遷移する。
   else
    flash[:notice] = "1 error prohibited this obj from being saved"
       render :edit#編集に失敗した場合現在のページにとどまる。
  end
end


  def destroy
  	@book = Book.find(params[:id])#投稿した本を区別する為のカラム（id）の振り分け。
  	@book.destroy#投稿した情報（投稿したbookのインスタンス変数）を削除する指示。
  	redirect_to books_path#削除に成功した場合booksの一覧（index)に遷移する。
  end

private#境界線。ここから下はcontrollerの中でしか呼び出せませんという意味があります。そのため、他のアクション（index,show,createなど）を巻き込まないようにprivateはControllerファイルの一番下のendのすぐ上に書いて下さい。

   def book_params
	params.require(:book).permit(:title, :body)
end
end
#@のついたインスタンス変数とローカル変数の違いは@のついているインスタンス変数はビューファイルへ受け渡すことができます。
#一方でローカル変数は、ビューファイルに受け渡しができません。アクション内でしか利用できません。今回はビューファイルへの受け渡しが必要ではないため、ローカル変数を利用しています。インスタンス変数でも同様の処理はできますが、無駄に利用できる範囲が広い変数は、今後、沢山の変数を利用するようになった際、不具合が起きやすい原因になります。
#これで、フォームからデータを受け取りデータベースへ保存できる形ができました。
