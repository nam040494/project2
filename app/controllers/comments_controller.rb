class CommentsController < ApplicationController
 def index
  @comments = Comment.all
 end

 def new
  @comment = Comment.new
 end

 def create
  @micropost = Micropost.find_by id: params[:micropost_id]
  @comment = @micropost.comments.build(comment_params)
  @comment.user = current_user
  if @comment.save
   flash[:success] = t ".success"
   redirect_to root_path
  else
   flash[:error] = t ".error"
   redirect_to root_path
  end
 end

 def show
 end

 def edit
 end

 def update
  if @comment.update
   flash[:success] = t ".update_success"
  else
   flash[:danger] = t ".update_error"
  end
 end

 def destroy
  @comment.destroy
  redirect_to '/'
 end

 private

  def comment_params
   params.require(:comment).permit :content
  end
end
