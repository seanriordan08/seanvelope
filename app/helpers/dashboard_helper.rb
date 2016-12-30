module DashboardHelper

  def get_district(id)
    BasinMetrics::District.find(id)
  end

  def get_wells
    BasinMetrics::Well.find_each do |well|
      well
    end
  end

end
