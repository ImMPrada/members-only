class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      respond_to { |format| update_post_comments_list(format) }
    else
      respond_to do |format|
        format.html { render :new, notice: 'Comment was not created.' }
      end
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def update_post_comments_list(format)
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.prepend(:post_comments_list,
                             partial: 'partials/comments/card',
                             locals: { comment: @comment }),
        turbo_stream.update(:new_post_comment_form, ''),
        turbo_stream.update(:post_comments_list_empty_message, '')
      ]
    end
    format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
  end
end
