class PostsController < TenantBaseController
  before_action :set_post, except: %i[index]

  def index
    authorize Post

    @posts = policy_scope(Post).page(page).per(per_page)
    @posts = @posts.published if params[:published].present?
  end

  def show
  end

  def new
    authorize Post
    post
  end

  def create
    authorize Post
    post.attributes = post_params
    respond_to do |format|
      if post.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_row", partial: "row", locals: { post: post }) }
        format.html { redirect_to posts_path, notice: "Post created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("post_form", partial: "form", locals: { post: post }) }
        format.html { render :new }
      end
    end
  end

  def update
    authorize post
    post.attributes = post_params
  end

  def destroy
    authorize post
    post.destroy
  end

  private

  attr_reader :post

  def set_post
    @post ||= if params[:id]
      Post.find_by(id: params[:id])
    else
      Post.new(author_id: current_user.id)
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end
end
