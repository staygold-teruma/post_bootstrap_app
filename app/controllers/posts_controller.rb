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
    @post = Post.new(post_params)
   
    if @post.save
      redirect_to @post, notice: "投稿しました"
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

# バリデーションエラー時は レンダリング を使用
# 保存が失敗した際に リダイレクト ではなく レンダリング を使用
# render :new ではなく redirect_to action: :new のようにリダイレクトさせると、
# 入力した情報が全て消えてしまい、入力した文字が全て消えてしまう
# ※コントローラで設定したインスタンス変数 @post などの情報は，リダイレクト時に全て消える

# render :new のようにレンダリングさせると、入力値を残したまま新規投稿ページに戻すことができる
# 例えば new アクションにレンダリングする際は、new.html.erb で使用している @post が必要
# ※new アクションは動作しない
# そのためcreateアクションの post を @post に変更している



  # redirect_to post のpostは保存に成功したPostオブジェクトのID値を返す
  # IDが3の場合は「/posts/3」にリダイレクトされる

  def edit
    # @post = Post.find(params[:id])
  end

  def update
    # post = Post.find(params[:id])
    # before_actionで統一したため、@postに変更
    if @post.update(post_params)
      redirect_to @post, notice: "更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    # post = Post.find(params[:id])
    # before_actionで統一したため、@postに変更
    @post.destroy!
    redirect_to root_path, alert:"削除しました"
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
