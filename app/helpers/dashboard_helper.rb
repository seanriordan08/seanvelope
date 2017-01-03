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

  def customers_exist?
    BasinMetrics::Customer.exists?
  end

  def get_customer(id)
    BasinMetrics::Customer.find(id)
  end

  def get_customer_names
    BasinMetrics::Customer.all.order(:name).collect(&:name)
  end

  def customers_missing?
    !BasinMetrics::Customer.exists?
  end

  def districts_exist?
    BasinMetrics::District.exists?
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
