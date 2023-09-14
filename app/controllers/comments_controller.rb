class CommentsController < ApplicationController
  before_action :load_estimate
  before_action :load_comment, only: [:edit,:update,:show,:destroy]
  #before_action :authenticate_user!

  def load_estimate
    @estimate = Estimate.find(params[:estimate_id])
    @comment = Comment.new
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def edit
  end

  def create
    @comment = @estimate.build_comment(comment_params)
    if @comment.save
      redirect_to estimate_path(@estimate)
    else
      render 'new'
    end
  end
  
  def destroy
    @comment = @estimate.comment
    @comment.destroy
    redirect_to estimate_path(@estimate)
  end
  
  def update
    @comment = @estimate.comment
    if @comment.update(comment_params)
      redirect_to estimate_path(@estimate)
    else
      render 'edit'
    end
  end

  private
 	def comment_params
 		params.require(:comment).permit(
 		:asahi,
    :cocacola,
    :dydo,
    :itoen,
    :kirin,
    :otsuka,
    :suntory,
    :yamakyu,
    :neos,
    :net,
    :body
    )
 	end
end
