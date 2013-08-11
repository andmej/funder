class FundsController < ApplicationController
  def index
    @funds = Fund.order(corporate_name: :asc)
  end
end
