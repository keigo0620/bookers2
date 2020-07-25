class UsersController < ApplicationController
  before_action :authenticate_user!
  def new#新しい本の投稿の指示
        @book = Book.new
  end

  def show#home画面の表示の指示
    @book = Book.new#新しい本の投稿の表示
  	@user = User.find(params[:id])#投稿したuserを区別する為のカラム（id）の振り分け。
    @books = @user.books#本の投稿とゆう@booksインスタンス変数に@userの投稿したbooks情報を代入して表示させる。
  end


  def edit#booksのeditに遷移する。
       @user = User.find(params[:id])#投稿したuserを区別する為のカラム（id）の振り分け。
    if @user != current_user#もしログイン済のuserが編集に成功したら？
      redirect_to user_path(current_user.id)#booksのshowに遷移する。
    end
  end

  def update#投稿した情報の編集に成功した場合の挙動
  	@user = User.find(params[:id])#投稿したuserを区別する為のカラム（id）の振り分け。
    if @user.update(user_params)#もし投稿の編集に成功し、情報の更新に成功したら？
    flash[:notice] = "You have creatad book successfully."#成功した場合のサクセスメッセージ表示の構文。
    redirect_to user_path(@user.id)#成功した場合の遷移ページ先。
    else
    flash[:notice] = "error prohibited this obj from being saved"#失敗した場合のエラーメッセージの構文。
    render :edit#投稿に失敗した場合の遷移ページの指定。renderとredirect_toの違いについてはbooks_controllerbのメモを参照。
    end
end
  def index#user一覧の参照。
    @user = current_user#ログイン済のuserの一覧ページの表示。
    @book = Book.new#booksの新規投稿の情報を表示。
    @users = User.all#一覧ページ（usersのindexページ！）にuserのの投稿データの全てを表示＊＠マークのついているインスタンス変数はviewページに表示。
  end
  #＝＝＝＝＝＝＝＝＝＝＝フォロー関係追加===========
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
  #＝＝＝＝＝＝＝＝＝＝＝フォロー関係追加===========
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
