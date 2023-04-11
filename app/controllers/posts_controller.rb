class PostsController < ApplicationController
  def new; end

  def create; end

  def show
    @post = Post.find(params[:id])
  end

  def destroy; end
end
