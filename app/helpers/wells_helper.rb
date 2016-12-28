module WellsHelper

  def get_customer(id)
    BasinMetrics::Customer.find(id)
  end

  def get_customers_options
    customer_ids = BasinMetrics::Customer.all.map(&:id)
    customer_names = BasinMetrics::Customer.all.map(&:name)

    build_options(customer_ids, customer_names)
  end

  def get_customers_string
    customer_names = BasinMetrics::Customer.all.map(&:name)
    customer_names.join("\",\"")
  end

  def get_customer_well_counts
    customers = BasinMetrics::Customer.all
    well_count = customers.collect do |c|
      BasinMetrics::Well.where(customer_id: c).size
    end
    well_count.join(',')
  end

  def get_district(id)
    BasinMetrics::District.find(id)
  end

  def get_districts_options
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
