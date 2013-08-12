module FundsHelper

  # Receives a list of dates and finds the first and last month that contain
  # one of the given dates. For each of those months yields the block with
  # two arguments: the first and last day in that month.
  # Months are yielded in chronologically descending order.
  def each_covered_month(dates, &block)
    lowest_date = dates.min.beginning_of_month
    highest_date = dates.max.beginning_of_month
    first_day = highest_date
    while first_day >= lowest_date
      last_day = first_day + 1.month - 1.day
      yield first_day, last_day
      first_day = first_day - 1.month
    end
  end
end
