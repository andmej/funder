class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])
    respond_to do |format|
      format.text { render text: @document.plain_text }
    end
  end

  def whats_new
    @documents = Document.order(created_at: :desc).limit(10)
  end
end
