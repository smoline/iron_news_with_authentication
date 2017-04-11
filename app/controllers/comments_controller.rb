class CommentsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "password", only: :destroy

  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.create(comment_params)
    redirect_to story_path(@story)
  end

  def destroy
      @story = Story.find(params[:story_id])
      @comment = @story.comments.find(params[:id])
      @comment.destroy
      redirect_to story_path(@story)
    end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
