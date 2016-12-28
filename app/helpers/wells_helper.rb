module WellsHelper

  def get_customers
    customer_ids = BasinMetrics::Customer.all.map(&:id)
    customer_names = BasinMetrics::Customer.all.map(&:name)

    build_customer_options(customer_ids, customer_names)
  end

  def get_customers
    customer_ids = BasinMetrics::Customer.all.map(&:id)
    customer_names = BasinMetrics::Customer.all.map(&:name)

    build_options(customer_ids, customer_names)
  end

  def get_districts
    district_ids = BasinMetrics::District.all.map(&:id)
    district_names = BasinMetrics::District.all.map(&:name)

    build_options(district_ids, district_names)
  end


  private

  def build_options(ids, names)
    options = []
    ids.each_with_index do |c_id, index|
      options << [names[index], c_id]
    end
    options
  end
end
