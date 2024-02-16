class CardCommentsController < ApplicationController
  before_action :authenticate_auth!
  before_action :set_card_comment, only: %i[ show edit update destroy ]

  # POST /card_comments
  def create
    @card_comment = CardComment.new(card_comment_params)
    respond_to do |format|
      if @card_comment.save
        format.html { redirect_to card_path(@card_comment.card_id) }
        format.json { render :show, status: :created, location: card_path(@card_comment.card_id) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_comments/1
  def update
    respond_to do |format|
      if @card_comment.update(card_comment_params)
        format.html { redirect_to card_path(@card_comment.card_id), notice: "Card comment was successfully updated." }
        format.json { render :show, status: :ok, location: @card_comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_comments/1
  def destroy
    @card_comment.destroy!

    respond_to do |format|
      format.html { redirect_to card_path(@card_comment.card_id) }
      format.json { head :no_content }
    end
  end

  private

  def set_card_comment
    @card_comment = CardComment.find(params[:id])
  end

  def card_comment_params
    params.require(:card_comment).permit(:text, :card_id, :auth_id)
  end
end