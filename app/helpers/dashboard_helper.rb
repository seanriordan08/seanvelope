module DashboardHelper

  def get_district(id)
    BasinMetrics::District.find(id)
  end

  def customers_missing?
    !BasinMetrics::Customer.exists?(1)
  end

  def districts_missing?
    !BasinMetrics::District.exists?(1)
  end

  def wells_missing?
    !BasinMetrics::Well.exists?(1)
  end

end
