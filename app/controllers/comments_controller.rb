class CommentsController < ApplicationController
  before_action :authorize!

  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.create(comment_params)
    @comment.created_by = current_user

    if @comment.save
      redirect_to story_path(@story), notice: 'Comment was successfully created.'
    else
      redirect_to story_path(@story), notice: 'Comment was not saved.'
    end
  end

  def destroy
    @story = Story.find(params[:story_id])
    @comment = @story.comments.find(params[:id])

    unless @story.can_this_user_destroy?(user)
      send_them_back_with_error
      return
    end

    @comment.destroy
    redirect_to story_path(@story), notice: 'Item was successfully destroyed'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
