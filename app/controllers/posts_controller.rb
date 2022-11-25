class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update create destroy react_post react_comment]
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  def create_comment
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_url(@comment.post), notice: "Comment was successfully created." 
    else
      redirect_to post_url(@comment.post), alert: "Fail to create comment." 
    end
  end

  def react_post
    @post = Post.find_by(id: params[:post_id])
    if params[:reaction] == 'liked'
      @post.liked_by current_user
    elsif params[:reaction] == 'disliked'
      @post.unliked_by current_user
    end
    redirect_to post_url(@post), notice: "Post was successfully #{params[:reaction]}." 
  end

  def react_comment
    comment = Comment.find_by(id: params[:comment_id])
    if params[:reaction] == 'liked'
      comment.liked_by current_user
    elsif params[:reaction] == 'disliked'
      comment.unliked_by current_user
    end
    redirect_to post_url(comment.post), notice: "Comment was successfully #{params[:reaction]}." 
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :user_id)
    end

    def comment_params
      params.require(:comment).permit(:description, :user_id, :post_id)
    end
end
