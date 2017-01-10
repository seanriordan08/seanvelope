module DashboardHelper

  def get_context
    request.env['PATH_INFO'].split('/').last.singularize.titleize
  end

  def get_district_names
    BasinMetrics::District.all.order(:name).collect(&:name)
  end

  def get_district(id)
    BasinMetrics::District.find(id)
  end

  def get_customer(id)
    BasinMetrics::Customer.find(id)
  end

  def get_customer_names
    BasinMetrics::Customer.all.order(:name).collect(&:name)
  end

end
