class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.order(id: :asc)
  end

  # Post.all では「編集時に順番が入れ替わってしまう」問題が起きるため
  # id順で並べるようにしておく

  def show
    # @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create!(post_params)
    redirect_to post
  end

  # redirect_to post のpostは保存に成功したPostオブジェクトのID値を返す
  # IDが3の場合は「/posts/3」にリダイレクトされる

  def edit
    # @post = Post.find(params[:id])
  end

  def update
    # post = Post.find(params[:id])
    # before_actionで統一したため、@postに変更
    @post.update!(post_params)
    redirect_to post
  end

  def destroy
    # post = Post.find(params[:id])
    # before_actionで統一したため、@postに変更
    @post.destroy!
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

# before_actionについては備忘録に残した
