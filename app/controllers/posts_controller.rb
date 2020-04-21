class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(5)
  end

  #どのタイミングでshowアクションの中身を消すのか
  def show
  end
  
  def new
    @post = Post.new
  end

  #登録フォームから送られてきたデータをデータベースに保存して、一覧画面に遷移する
  #redirect_toには特定の「Flashメッセージ」を渡すことができる。表示するためにはlayoutsに記述する
  def create
    @post = current_user.posts.new(post_params)
  
    if @post.save
      redirect_to @post, notice: "hikidashi「#{@post.name}」を登録しました。"
    else
      render :new
    end  
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "hikidashi「#{@post.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "hikidashi「#{@post.name}」を削除しました。"
  end

  private
  
  #受け取る情報だけを抜き取って、登録する役割
  def post_params
    params.require(:post).permit(:name, :description)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
