class FundsController < ApplicationController
  def index
    @funds = Fund.order(corporate_name: :asc).includes(:dividends, :documents)
  end

  def show
    @fund = Fund.find_by_ticker(params[:id]) || Fund.find(params[:id])
    @communications = @fund.documents.where(category: "Comunicados").order(published_at: :desc)
  end
end
