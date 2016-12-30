module DashboardHelper

  def get_district(id)
    BasinMetrics::District.find(id)
  end

  def customers_missing?
    !BasinMetrics::Customer.exists?
  end

  def districts_missing?
    !BasinMetrics::District.exists?
  end

  def wells_missing?
    !BasinMetrics::Well.exists?
  end

  def wells_exist?
    BasinMetrics::Well.exists?
  end

  def parts_exist?
    BasinMetrics::Part.exists?
  end

end
