module DashboardHelper

  def get_district(id)
    BasinMetrics::District.find(id)
  end

end
