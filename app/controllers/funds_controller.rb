class FundsController < ApplicationController
  def index
    @funds = Fund.order(corporate_name: :asc)
  end

  def show
    @fund = Fund.find_by_ticker(params[:id]) || Fund.find(params[:id])
  end
end
