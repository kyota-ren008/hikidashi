class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  #どのタイミングでshowアクションの中身を消すのか
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  #登録フォームから送られてきたデータをデータベースに保存して、一覧画面に遷移する
  #redirect_toには特定の「Flashメッセージ」を渡すことができる。表示するためにはlayoutsに記述する
  def create
    post = Post.new(post_params)
    post.save!
    redirect_to posts_url, notice: "hikidashi「#{post.name}」を登録しました。"
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    redirect_to posts_url, notice: "hikidashi「#{post.name}」を更新しました。"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_url, notice: "hikidashi「#{post.name}」を削除しました。"
  end

  private
  
  #受け取る情報だけを抜き取って、登録する役割
  def post_params
    params.require(:post).permit(:name, :description, :image)
  end
end
