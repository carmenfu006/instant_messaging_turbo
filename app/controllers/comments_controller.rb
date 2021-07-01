class CommentsController < ApplicationController

  def new
    @pin = Pin.find(params[:pin_id])
    @comment = Comment.new
  end

  def create
    pin = Pin.find(params[:pin_id])
    comment = pin.comments.create(comment_params)

    respond_to do |format|
      if comment.save
        format.turbo_stream { render turbo_stream: turbo_stream.append(:comments, partial: "comments/comment", locals: { comment: comment }) }
        format.html { redirect_to pin_path(pin) }
        # format.turbo_stream
        # format.html { redirect_to pin_path(pin) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(comment, partial: 'comments/form', locals: { comment: comment, pin: pin })}
        format.html { redirect_to pin_path(pin), notice: 'There was an error. Please try again.' }
      end
    end
  end

  def edit
    @pin = Pin.find(params[:pin_id])
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    pin = Pin.find(params[:pin_id])
    
    respond_to do |format|
      if comment.update(comment_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(comment, partial: "comments/comment", locals: { comment: comment }) }
        format.html { redirect_to pin_path(pin) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(comment, partial: 'comments/form', locals: { comment: comment, pin: pin }) }
        format.html { redirect_to pin_path(pin), notice: 'There was an error. Please try again.' }
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    pin = Pin.find(params[:pin_id])

    comment.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(comment) }
      format.html { redirect_to pin }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end