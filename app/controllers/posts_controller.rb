class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def new
    @clubhouse = Clubhouse.find(params[:clubhouse_id])
    @post = Post.new
  end

  def create
    @clubhouse = Clubhouse.find(params[:clubhouse_id])
    @post = Post.new(post_params)
    @post.user = current_user
    @post.clubhouse = @clubhouse

    if @post.save
      respond_to { |format| update_clubhouse_posts_list(format) }
    else
      respond_to do |format|
        format.html { render :new, notice: 'Post was not created.' }
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy; end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def update_clubhouse_posts_list(format)
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.prepend(:clubhouse_posts_list,
                             partial: 'partials/posts/card',
                             locals: { post: @post }),
        turbo_stream.update(:new_post_form, ''),
        turbo_stream.update(:clubhouse_posts_list_empty_message, '')
      ]
    end
    format.html { redirect_to clubhouse_path(@clubhouse), notice: 'User was successfully updated.' }
  end
end
