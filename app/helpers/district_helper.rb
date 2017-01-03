module DistrictHelper

  def get_district_customer_counts
    districts = BasinMetrics::District.all.order(:name)
    districts.collect do |c|
      BasinMetrics::Well.where(customer_id: c).size
    end
  end

end
