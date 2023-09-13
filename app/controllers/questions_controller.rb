class QuestionsController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show, :edit, :update, :destroy]
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result.page(params[:page]).per(100).order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
        redirect_to questions_path
    else
        render 'edit'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path, alert:"削除しました"
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to questions_path(@question), alert: "更新しました"
    else
      render 'edit'
    end
  end

  private
  def question_params
    params.require(:question).permit(
      :whats, #質問
      :category,  #カテゴリー
      :answer, #回答
    )
  end
end
