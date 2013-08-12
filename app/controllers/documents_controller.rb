class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])
    respond_to do |format|
      format.text { render text: @document.plain_text }
    end
  end
end
