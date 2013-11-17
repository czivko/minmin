class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order("id desc").limit(30)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.published_at = DateTime.now if @post.published_at.blank?
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    @posts = Post.where("'#{params[:search]}' = ANY (tags)
                        or  body like '%#{params[:search]}%'
                        or  title like '%#{params[:search]}%'
                      ")
               
    render :index
  end

  def share
    @post = Post.new(title: params[:t], body: "<a href=#{params[:u]}>#{params[:u]}</a>")
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.where(id: params[:id]).first
      @post = Post.where(slug: params[:id]).first if @post.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      pre_params = params.require(:post).permit(:title, :body, :slug, :post_type, :published_at, :tags)
      pre_params[:tags] = pre_params[:tags].downcase.split( /, */ )
      pre_params
    end
end
